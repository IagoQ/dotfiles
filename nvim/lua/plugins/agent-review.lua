-- Agent Review: Review coding agent diffs via quickfix with unified diff view
-- Toggle with <leader>gr

local M = {}

-- ═══════════════════════════════════════════════════════════════════════════
-- State
-- ═══════════════════════════════════════════════════════════════════════════

M.active = false
M.original_buf = nil
M.original_win = nil
M.diff_buf = nil
M.current_file = nil
M.augroup = vim.api.nvim_create_augroup("AgentReview", { clear = true })
M.ns_id = vim.api.nvim_create_namespace("AgentReviewHL")

-- ═══════════════════════════════════════════════════════════════════════════
-- Highlighting Setup
-- ═══════════════════════════════════════════════════════════════════════════

local function setup_highlights()
  -- Background colors for diff lines (subtle, desaturated)
  vim.api.nvim_set_hl(0, "AgentReviewAdd", { bg = "#2a3a2a", fg = "NONE" })
  vim.api.nvim_set_hl(0, "AgentReviewDelete", { bg = "#3a2a2a", fg = "NONE" })
  -- Line number highlights (like gitsigns numhl)
  vim.api.nvim_set_hl(0, "AgentReviewAddNr", { fg = "#98c379", bold = true })
  vim.api.nvim_set_hl(0, "AgentReviewDeleteNr", { fg = "#e06c75", bold = true })
end

setup_highlights()

-- ═══════════════════════════════════════════════════════════════════════════
-- Hunk Parsing
-- ═══════════════════════════════════════════════════════════════════════════

--- Parse git diff output and extract hunk information
---@return table[] List of hunks with file, line, adds, dels, context
function M.parse_hunks()
  local output = vim.fn.systemlist("git diff HEAD --no-color 2>/dev/null")
  if vim.v.shell_error ~= 0 or #output == 0 then
    return {}
  end

  local hunks = {}
  local current_file = nil
  local in_hunk = false
  local hunk_adds = 0
  local hunk_dels = 0

  for _, line in ipairs(output) do
    -- New file: diff --git a/path/to/file b/path/to/file
    local file_match = line:match("^diff %-%-git a/(.-) b/")
    if file_match then
      current_file = file_match
      in_hunk = false
    end

    -- Hunk header: @@ -old_start,old_count +new_start,new_count @@ context
    local new_start, new_count, context = line:match("^@@ %-%d+,?%d* %+(%d+),?(%d*) @@ ?(.*)")
    if new_start and current_file then
      -- If we were in a previous hunk, finalize its counts
      if in_hunk and #hunks > 0 then
        hunks[#hunks].adds = hunk_adds
        hunks[#hunks].dels = hunk_dels
      end

      -- Start new hunk
      in_hunk = true
      hunk_adds = 0
      hunk_dels = 0

      table.insert(hunks, {
        file = current_file,
        line = tonumber(new_start),
        count = tonumber(new_count) or 1,
        context = context ~= "" and context or nil,
        adds = 0,
        dels = 0,
      })
    end

    -- Count additions and deletions within hunk
    if in_hunk then
      if line:match("^%+[^%+]") or line == "+" then
        hunk_adds = hunk_adds + 1
      elseif line:match("^%-[^%-]") or line == "-" then
        hunk_dels = hunk_dels + 1
      end
    end
  end

  -- Finalize last hunk
  if in_hunk and #hunks > 0 then
    hunks[#hunks].adds = hunk_adds
    hunks[#hunks].dels = hunk_dels
  end

  return hunks
end

-- ═══════════════════════════════════════════════════════════════════════════
-- Quickfix Population
-- ═══════════════════════════════════════════════════════════════════════════

--- Format a hunk entry for display in quickfix
---@param hunk table Hunk data
---@return string Formatted text
local function format_hunk_text(hunk)
  local adds = string.format("+%d", hunk.adds)
  local dels = string.format("-%d", hunk.dels)
  local stats = string.format("%s %s", adds, dels)

  if hunk.context then
    return string.format("%-10s │ %s", stats, hunk.context)
  else
    return stats
  end
end

--- Populate quickfix list with parsed hunks
---@param hunks table[] List of hunks
function M.populate_quickfix(hunks)
  local qf_entries = {}

  for _, hunk in ipairs(hunks) do
    table.insert(qf_entries, {
      filename = hunk.file,
      lnum = hunk.line,
      col = 1,
      text = format_hunk_text(hunk),
      type = "I",
    })
  end

  vim.fn.setqflist({}, "r", {
    title = "Agent Review",
    items = qf_entries,
  })
end

-- ═══════════════════════════════════════════════════════════════════════════
-- Diff Buffer Display
-- ═══════════════════════════════════════════════════════════════════════════

--- Process diff output: strip +/- prefixes, remove meta/hunk lines, track line types
---@param diff_output string[] Raw diff lines
---@return string[] processed_lines Lines with prefixes stripped (no meta/hunk lines)
---@return table[] line_types Array of {type = "add"|"del"|"context"}
---@return table raw_to_processed Map from raw line index to processed line index
local function process_diff_output(diff_output)
  local processed = {}
  local line_types = {}
  local raw_to_processed = {}

  for i, line in ipairs(diff_output) do
    local line_type = nil
    local processed_line = nil

    if line:match("^@@") then
      -- Skip hunk headers
    elseif line:match("^%+%+%+") or line:match("^%-%-%-") then
      -- Skip file headers
    elseif line:match("^diff %-%-git") then
      -- Skip diff headers
    elseif line:match("^index ") then
      -- Skip index lines
    elseif line:match("^%+") then
      line_type = "add"
      processed_line = line:sub(2) -- Strip the +
    elseif line:match("^%-") then
      line_type = "del"
      processed_line = line:sub(2) -- Strip the -
    elseif line:match("^ ") then
      line_type = "context"
      processed_line = line:sub(2) -- Strip the leading space for alignment
    end

    if processed_line ~= nil then
      table.insert(processed, processed_line)
      table.insert(line_types, { type = line_type })
      raw_to_processed[i] = #processed
    end
  end

  return processed, line_types, raw_to_processed
end

--- Apply highlighting to diff buffer
---@param buf number Buffer handle
---@param line_types table[] Line type information
local function apply_diff_highlights(buf, line_types)
  vim.api.nvim_buf_clear_namespace(buf, M.ns_id, 0, -1)

  for i, info in ipairs(line_types) do
    local line_idx = i - 1

    if info.type == "add" then
      vim.api.nvim_buf_set_extmark(buf, M.ns_id, line_idx, 0, {
        line_hl_group = "AgentReviewAdd",
        number_hl_group = "AgentReviewAddNr",
      })
    elseif info.type == "del" then
      vim.api.nvim_buf_set_extmark(buf, M.ns_id, line_idx, 0, {
        line_hl_group = "AgentReviewDelete",
        number_hl_group = "AgentReviewDeleteNr",
      })
    end
  end
end

--- Get filetype from filename
---@param file string File path
---@return string filetype
local function get_filetype_for_file(file)
  local ft = vim.filetype.match({ filename = file })
  return ft or ""
end

--- Find the line number in processed diff that corresponds to a hunk starting at target_line
---@param raw_diff_lines string[] Original diff lines (with +/- prefixes)
---@param target_line number Target line number from quickfix
---@param raw_to_processed table Map from raw line index to processed line index
---@return number Line number in processed diff buffer to jump to
local function find_hunk_line_in_processed_diff(raw_diff_lines, target_line, raw_to_processed)
  for i, line in ipairs(raw_diff_lines) do
    local new_start = line:match("^@@ %-%d+,?%d* %+(%d+),?%d* @@")
    if new_start and tonumber(new_start) == target_line then
      -- Find the first processed line after this hunk header
      for j = i + 1, #raw_diff_lines do
        if raw_to_processed[j] then
          return raw_to_processed[j]
        end
      end
    end
  end
  return 1
end

--- Show unified diff for a file in a scratch buffer
---@param file string File path
---@param target_line number Line number to jump to (from hunk)
function M.show_file_diff(file, target_line)
  -- If same file, just jump to the hunk line
  if M.current_file == file and M.diff_buf and vim.api.nvim_buf_is_valid(M.diff_buf) then
    local jump_line = find_hunk_line_in_processed_diff(M.raw_diff_lines or {}, target_line, M.raw_to_processed or {})
    if M.original_win and vim.api.nvim_win_is_valid(M.original_win) then
      vim.api.nvim_win_set_cursor(M.original_win, { jump_line, 0 })
      vim.cmd("normal! zz")
    end
    return
  end

  -- Get diff for this specific file
  local diff_output = vim.fn.systemlist(string.format("git diff HEAD -- %s 2>/dev/null", vim.fn.shellescape(file)))
  if vim.v.shell_error ~= 0 or #diff_output == 0 then
    vim.notify("No diff for " .. file, vim.log.levels.WARN)
    return
  end

  -- Store raw diff for line finding
  M.raw_diff_lines = diff_output

  -- Process diff: strip prefixes, remove meta lines, track line types
  local processed_lines, line_types, raw_to_processed = process_diff_output(diff_output)
  M.raw_to_processed = raw_to_processed

  -- Create or reuse diff buffer
  if not M.diff_buf or not vim.api.nvim_buf_is_valid(M.diff_buf) then
    M.diff_buf = vim.api.nvim_create_buf(false, true)
  end

  -- Make buffer modifiable to set content
  vim.api.nvim_set_option_value("modifiable", true, { buf = M.diff_buf })

  -- Set buffer content (processed, without +/- prefixes, no meta lines)
  vim.api.nvim_buf_set_lines(M.diff_buf, 0, -1, false, processed_lines)

  -- Configure buffer
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = M.diff_buf })
  vim.api.nvim_set_option_value("bufhidden", "hide", { buf = M.diff_buf })
  vim.api.nvim_set_option_value("swapfile", false, { buf = M.diff_buf })
  vim.api.nvim_set_option_value("modifiable", false, { buf = M.diff_buf })
  vim.api.nvim_set_option_value("buflisted", false, { buf = M.diff_buf })
  pcall(vim.api.nvim_buf_set_name, M.diff_buf, string.format("[Review] %s", file))

  -- Set filetype based on the actual file for syntax highlighting
  local ft = get_filetype_for_file(file)
  if ft and ft ~= "" then
    vim.api.nvim_set_option_value("filetype", ft, { buf = M.diff_buf })
  end

  -- Apply custom highlighting (background colors + numhl) on top of syntax
  apply_diff_highlights(M.diff_buf, line_types)

  -- Show buffer in original window
  if M.original_win and vim.api.nvim_win_is_valid(M.original_win) then
    vim.api.nvim_win_set_buf(M.original_win, M.diff_buf)

    -- Enable line numbers for numhl to work
    vim.api.nvim_set_option_value("number", true, { win = M.original_win })

    -- Jump to the relevant hunk
    local jump_line = find_hunk_line_in_processed_diff(diff_output, target_line, raw_to_processed)
    vim.api.nvim_win_set_cursor(M.original_win, { jump_line, 0 })
    vim.cmd("normal! zz")
  end

  M.current_file = file
end

-- ═══════════════════════════════════════════════════════════════════════════
-- Quickfix Navigation Handler
-- ═══════════════════════════════════════════════════════════════════════════

--- Handle quickfix selection/navigation
function M.on_quickfix_change()
  if not M.active then
    return
  end

  local qf_info = vim.fn.getqflist({ idx = 0, items = 0 })
  local idx = qf_info.idx
  local items = vim.fn.getqflist()

  if idx > 0 and idx <= #items then
    local entry = items[idx]
    local file = vim.fn.bufname(entry.bufnr)
    if file == "" then
      file = entry.filename or ""
    end

    if file ~= "" then
      M.show_file_diff(file, entry.lnum)
    end
  end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- Activation / Deactivation
-- ═══════════════════════════════════════════════════════════════════════════

--- Activate review mode
function M.activate()
  -- Parse hunks
  local hunks = M.parse_hunks()
  if #hunks == 0 then
    vim.notify("No uncommitted changes to review", vim.log.levels.INFO)
    return
  end

  -- Save current state
  M.original_buf = vim.api.nvim_get_current_buf()
  M.original_win = vim.api.nvim_get_current_win()
  M.current_file = nil

  -- Populate quickfix
  M.populate_quickfix(hunks)

  -- Open quickfix window
  vim.cmd("copen")

  -- Set up autocmds for navigation
  vim.api.nvim_clear_autocmds({ group = M.augroup })

  local qf_bufnr = vim.fn.getqflist({ qfbufnr = 0 }).qfbufnr

  -- Handle quickfix cursor movement
  vim.api.nvim_create_autocmd("CursorMoved", {
    group = M.augroup,
    buffer = qf_bufnr,
    callback = function()
      M.on_quickfix_change()
    end,
  })

  -- Handle quickfix window close
  vim.api.nvim_create_autocmd("BufWinLeave", {
    group = M.augroup,
    buffer = qf_bufnr,
    callback = function()
      -- Defer to avoid issues during event
      vim.schedule(function()
        if M.active then
          M.deactivate()
        end
      end)
    end,
  })

  -- Override ]q and [q to use our navigation while in review mode
  -- We avoid :cnext/:cprev because they jump to the file, opening a new buffer
  vim.keymap.set("n", "]q", function()
    if M.active then
      local qf_win = vim.fn.getqflist({ winid = 0 }).winid
      local items = vim.fn.getqflist()
      local idx = vim.fn.getqflist({ idx = 0 }).idx

      if idx < #items then
        -- Move to next item without jumping to file
        vim.fn.setqflist({}, "a", { idx = idx + 1 })
        -- Move cursor in quickfix window if it's open
        if qf_win and qf_win ~= 0 then
          local qf_buf = vim.api.nvim_win_get_buf(qf_win)
          local cursor = vim.api.nvim_win_get_cursor(qf_win)
          if cursor[1] < #items then
            vim.api.nvim_win_set_cursor(qf_win, { cursor[1] + 1, 0 })
          end
        end
        M.on_quickfix_change()
      end
    else
      vim.cmd("cnext")
    end
  end, { desc = "Next quickfix item" })

  vim.keymap.set("n", "[q", function()
    if M.active then
      local qf_win = vim.fn.getqflist({ winid = 0 }).winid
      local idx = vim.fn.getqflist({ idx = 0 }).idx

      if idx > 1 then
        -- Move to prev item without jumping to file
        vim.fn.setqflist({}, "a", { idx = idx - 1 })
        -- Move cursor in quickfix window if it's open
        if qf_win and qf_win ~= 0 then
          local cursor = vim.api.nvim_win_get_cursor(qf_win)
          if cursor[1] > 1 then
            vim.api.nvim_win_set_cursor(qf_win, { cursor[1] - 1, 0 })
          end
        end
        M.on_quickfix_change()
      end
    else
      vim.cmd("cprev")
    end
  end, { desc = "Prev quickfix item" })

  M.active = true

  -- Show first diff (use schedule to let quickfix settle)
  vim.schedule(function()
    M.on_quickfix_change()
  end)

  vim.notify(string.format("Review mode: %d hunks across %d files",
    #hunks,
    #vim.tbl_keys(vim.tbl_groupby and vim.tbl_groupby(hunks, function(h) return h.file end) or {})
  ), vim.log.levels.INFO)
end

--- Deactivate review mode
function M.deactivate()
  -- Clear autocmds
  vim.api.nvim_clear_autocmds({ group = M.augroup })

  -- Restore original ]q [q mappings
  vim.keymap.set("n", "]q", ":cnext<CR>", { desc = "Next quickfix item" })
  vim.keymap.set("n", "[q", ":cprev<CR>", { desc = "Prev quickfix item" })

  -- Close quickfix window
  vim.cmd("cclose")

  -- Wipe diff buffer
  if M.diff_buf and vim.api.nvim_buf_is_valid(M.diff_buf) then
    vim.api.nvim_buf_delete(M.diff_buf, { force = true })
  end

  -- Restore original buffer if window still valid
  if M.original_win and vim.api.nvim_win_is_valid(M.original_win) and
     M.original_buf and vim.api.nvim_buf_is_valid(M.original_buf) then
    vim.api.nvim_win_set_buf(M.original_win, M.original_buf)
  end

  -- Reset state
  M.active = false
  M.original_buf = nil
  M.original_win = nil
  M.diff_buf = nil
  M.current_file = nil
  M.raw_diff_lines = nil
  M.raw_to_processed = nil

  vim.notify("Review mode ended", vim.log.levels.INFO)
end

--- Toggle review mode
function M.toggle()
  if M.active then
    M.deactivate()
  else
    M.activate()
  end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- Lazy.nvim Plugin Spec
-- ═══════════════════════════════════════════════════════════════════════════

-- Store module in global for access from keymap
_G.AgentReview = M

return {
  dir = vim.fn.stdpath("config") .. "/lua/plugins",
  name = "agent-review",
  keys = {
    {
      "<leader>gr",
      function()
        _G.AgentReview.toggle()
      end,
      desc = "Toggle agent diff review",
    },
  },
}
