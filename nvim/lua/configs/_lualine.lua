-- -- -- Dracula Colors
-- -- local colors = {
-- --   white = '#feffff',
-- --   red = '#ff6d67',
-- --   grey = '#abb2bf',
-- --   gray = '#55596d',
-- --   black = '#323844',
-- --   transparent = '#282a36',
-- --   green = '#59f68d',
-- --   yellow = '#f3f89d',
-- --   blue = '#61afef',
-- --   magenta = '#ff92d0',
-- --   cyan = '#99ecfd',
-- --   orange = '#ff8700',
-- -- }

-- -- local dracula = {
-- --   normal = {
-- --     a = { fg = colors.grey, bg = colors.black },
-- --     b = { fg = colors.grey,  bg = colors.black },
-- --     c = { fg = colors.gray, bg = colors.transparent },
-- --     z = { fg = colors.grey, bg = colors.black },
-- --   },
-- --   insert = { a = { fg = colors.transparent, bg = colors.green } },
-- --   visual = { a = { fg = colors.transparent, bg = colors.yellow } },
-- --   replace = { a = { fg = colors.transparent, bg = colors.red } },
-- -- }

-- -- One Dark Pro Colors
-- local colors = {
--   white = '#ffffff',
--   red = '#e06c75',
--   grey = '#abb2bf',
--   gray = '#495254',
--   black = '#323844',
--   transparent = '#282c34',
--   green = '#98c379',
--   yellow = '#e5c07b',
--   blue = '#61afef',
--   magenta = '#c678dd',
--   cyan = '#56b6c2',
--   orange = '#ff8700',
-- }

-- -- local onedarkpro = {
-- --   normal = {
-- --     a = { fg = colors.grey, bg = colors.black },
-- --     b = { fg = colors.grey,  bg = colors.black },
-- --     c = { fg = colors.gray, bg = colors.transparent },
-- --     z = { fg = colors.grey, bg = colors.black },
-- --   },
-- --   insert = { a = { fg = colors.transparent, bg = colors.yellow } },
-- --   visual = { a = { fg = colors.transparent, bg = colors.green } },
-- --   replace = { a = { fg = colors.transparent, bg = colors.green } },
-- -- }

-- -- Iceberg Colors
-- -- local colors = {
-- --   red = '#f44747',
-- --   grey = '#f5f5f5',
-- --   black = '#1e2132',
-- --   blk = '#000000',
-- --   white = '#ffffff',
-- --   transparent = '#161821',
-- --   green = '#b1bb80',
-- --   yellow = '#f2b589',
-- --   cyan = '#8ab8c2',
-- --   blue = '#84a0c6',
-- --   magenta = '#df89dd'
-- -- }

-- -- local iceberg = {
-- --   normal = {
-- --     a = { fg = colors.blk, bg = colors.cyan },
-- --     b = { fg = colors.gray,  bg = colors.black },
-- --     c = { fg = colors.light_grey, bg = colors.transparent },
-- --     z = { fg = colors.gray, bg = colors.black },
-- --   },
-- --   insert = { a = { fg = colors.blk, bg = colors.yellow } },
-- --   visual = { a = { fg = colors.blk, bg = colors.green } },
-- --   replace = { a = { fg = colors.blk, bg = colors.green } },
-- -- }

-- -- Inspired Github Colors
-- -- local colors = {
-- --   red = '#ca1243',
-- --   grey = '#f5f5f5',
-- --   light_grey = '#979BAC',
-- --   black = '#383a42',
-- --   white = '#ffffff',
-- --   transparent = '#ffffff',
-- --   light_green = '#83a598',
-- --   orange = '#fe8019',
-- --   green = '#8ec07c',
-- --   yellow = '#f8eec7',
-- --   cyan = '#489FC1',
-- -- }

-- -- local inspired_github = {
-- --   normal = {
-- --     a = { fg = colors.white, bg = colors.red },
-- --     b = { fg = colors.black,  bg = colors.grey },
-- --     c = { fg = colors.light_grey, bg = colors.white },
-- --     z = { fg = colors.white, bg = colors.black },
-- --   },
-- --   insert = { a = { fg = colors.black, bg = colors.yellow } },
-- --   visual = { a = { fg = colors.white, bg = colors.cyan } },
-- --   replace = { a = { fg = colors.black, bg = colors.green } },
-- -- }

-- local empty = require('lualine.component'):extend()
-- function empty:draw(default_highlight)
--   self.status = ''
--   self.applied_separator = ''
--   self:apply_highlights(default_highlight)
--   self:apply_section_separators()
--   return self.status
-- end

-- -- Put proper separators and gaps between components in sections
-- local function process_sections(sections)
--   for name, section in pairs(sections) do
--     local left = name:sub(9, 10) < 'x'
--     for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
--       table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.transparent } })
--     end
--     for id, comp in ipairs(section) do
--       if type(comp) ~= 'table' then
--         comp = { comp }
--         section[id] = comp
--       end
--       -- comp.separator = left and { right = '???' } or { left = '???' }
--       comp.separator = left and { right = '???' } or { left = '???' }
--     end
--   end
--   return sections
-- end

-- local function search_result()
--   if vim.v.hlsearch == 0 then
--     return ''
--   end
--   local last_search = vim.fn.getreg('/')
--   if not last_search or last_search == '' then
--     return ''
--   end
--   local searchcount = vim.fn.searchcount { maxcount = 9999 }
--   return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
-- end

-- local function modified()
--   if vim.bo.modified then
--     return '+'
--   elseif vim.bo.modifiable == false or vim.bo.readonly == true then
--     return '-'
--   end
--   return ''
-- end

-- -- vim.g.gitblame_display_virtual_text = 0
-- -- local git_blame = require('gitblame')

-- require('lualine').setup {
--     icons_enabled = false,
--     options = {
--     -- theme = onedarkpro,
--     component_separators = '',
--     globalstatus = true,
--   },
--   -- process_sections
--   sections = process_sections {
--     lualine_a = { 'mode' },
--     lualine_b = {
--       'branch',  
--       { 'filename', file_status = false, path = 3 },
--       {
--         'diagnostics',
--         source = { 'intelephense', 'quick-lint-js' },
--         sections = { 'error' },
--         diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
--       },
--       {
--         'diagnostics',
--         source = { 'intelephense', 'quick-lint-js' },
--         sections = { 'warn' },
--         diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
--       },
--       {
--         'diagnostics',
--         source = { 'intelephense', 'tsserver' },
--         sections = { 'hint' },
--         diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
--       },
--       { modified, color = { fg = colors.transparent, bg = colors.green } },
--     },
--     -- lualine_c = {'aerial' },
--     -- lualine_x = {{ git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available  }},
--     lualine_y = { search_result, 'filetype' },
--     lualine_z = { '%l:%c', '%p%%/%L' },
--   },
--   inactive_sections = {
--     lualine_c = { '%f %y %m' },
--     lualine_x = {},
--   },
-- }

-- Lua
vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text

vim.g.gitblame_date_format = '%r'

-- local git_blame = require('gitblame')

local colors = {
  white = '#ffffff',
  red = '#e06c75',
  grey = '#abb2bf',
  gray = '#495254',
  black = '#323844',
  transparent = '#282c34',
  green = '#98c379',
  yellow = '#e5c07b',
  blue = '#61afef',
  magenta = '#c678dd',
  cyan = '#56b6c2',
  orange = '#ff8700',
}

require('lualine').setup({
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        'branch',  
        { 'filename', file_status = false, path = 3 },
        {
          'diagnostics',
          source = { 'intelephense', 'quick-lint-js' },
          sections = { 'error' },
          diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
        },
        {
          'diagnostics',
          source = { 'intelephense', 'quick-lint-js' },
          sections = { 'warn' },
          diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
        },
        {
          'diagnostics',
          source = { 'intelephense', 'tsserver' },
          sections = { 'hint' },
          diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
        },
        { modified, color = { fg = colors.transparent, bg = colors.green } },
      },
      -- lualine_c = { { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available } },
      -- lualine_y = { search_result, 'filetype' },
      lualine_x = {'encoding', 'filetype'},
      -- lualine_z = { '%l:%c', '%p%%/%L' },
    }
})
