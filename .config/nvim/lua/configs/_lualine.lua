local git_blame = require('gitblame')
vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
vim.g.gitblame_date_format = '%r'


require('lualine').setup({
  disabled_filetypes = {
      statusline = {},
      winbar = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "alpha",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
      },
    },
    theme = { "onedark" },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        'branch',  
        { 'filename', file_status = false, path = 3 },
        {
          'diagnostics',
          source = { 'intelephense', 'quick-lint-js' },
          sections = { 'error' },
        },
        {
          'diagnostics',
          source = { 'intelephense', 'quick-lint-js' },
          sections = { 'warn' },
        },
        {
          'diagnostics',
          source = { 'intelephense', 'tsserver' },
          sections = { 'hint' },
        },
      },
      lualine_c = { { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available } },
      -- lualine_y = { search_result, 'filetype' },
      lualine_x = {'encoding', 'filetype'},
      -- lualine_z = { '%l:%c', '%p%%/%L' },
    }
})
