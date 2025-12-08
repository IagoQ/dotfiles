function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = false })
end

-- resize with arrow
map("n", "<C-Up>", ":resize -2<CR>")

map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Copy/paste to clipboard
map("v", "<leader>p", "\"0p")
map("n", "<leader>p", "\"0p")

-- Yank current buffer filename
map("n", "yn", ":let @+ = expand('%')<CR>")

-- remove highlights after /
map("n", "<esc>", ":noh<return><esc>")

-- save on ctrls s
map("n", "<C-S>", ":wa!<CR>")
map("v", "<C-S>", "<Esc>:wa!<CR>")
map("i", "<C-S>", "<Esc>:wa!<CR>")

-- move lines
map("n", "<A-j>", ":m .+1<CR>")
map("n", "<A-k>", ":m .-2<CR>")
map("i", "<A-j>", "<Esc>:m .+1<CR>")
map("i", "<A-k>", "<Esc>:m .-2<CR>")
map("v", "<A-j>", ":m '>+1<CR>gv")
map("v", "<A-k>", ":m '<-2<CR>gv")

-- NvimTree mapping moved to plugins/general.lua for lazy loading

-- Mapings: telescope
map("n", "s", "<Nop>")
map("v", "s", "<Nop>")
-- map("n", "sf", "<cmd>lua require('telescope.builtin').find_files()<CR>")
-- map("n", "sa", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
-- map("n", "sb", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
-- map("n", "sh", "<cmd>lua require('telescope.builtin').help_tags()<CR>")
-- map("n", "so", "<cmd>lua require('telescope.builtin').oldfiles()<CR>")
-- map("n", "sq", "<cmd>lua require('telescope.builtin').quickfix()<CR>")
-- map("n", "sj", "<cmd>lua require('telescope.builtin').jumplist()<CR>")
-- map("n", "sw", "<cmd>lua require('telescope.builtin').grep_string()<CR>")
-- map("v", "sw", "<cmd>lua require('telescope.builtin').grep_string()<CR>")



--quickfixlist
vim.keymap.set("n", "]q", ":cn<CR>")
vim.keymap.set("n", "[q", ":cp<CR>")


--  This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local bufnr = event.buf

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Show the hover documentation for the word under your cursor.
    map('K', vim.lsp.buf.hover, 'Hover Documentation')

    -- Show signature help for the function under your cursor.
    map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help')
    map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help', 'i')

    -- Rename the variable under your cursor.
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    -- Open a floating window with diagnostics for the current line.
    map('<leader>e', vim.diagnostic.open_float, 'Show diagnostic [E]rror messages')

    -- Jump to the previous diagnostic in the current buffer.
    map('[d', vim.diagnostic.goto_prev, 'Go to previous [D]iagnostic message')

    -- Jump to the next diagnostic in the current buffer.
    map(']d', vim.diagnostic.goto_next, 'Go to next [D]iagnostic message')

    -- Format the current buffer.
    map('<leader>f', vim.lsp.buf.format, '[F]ormat buffer')

    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })


    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    --
    local function client_supports_method(client, method, bufnr)
      if vim.fn.has 'nvim-0.11' == 1 then
        return client:supports_method(method, bufnr)
      else
        return client.supports_method(method, { bufnr = bufnr })
      end
    end
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,
})
