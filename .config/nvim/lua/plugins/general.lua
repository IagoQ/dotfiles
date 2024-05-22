return {
  'kdheepak/lazygit.nvim',

  'mbbill/undotree',
  'ThePrimeagen/harpoon',
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signcolumn = false,
      numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
    },
  },

  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons'
    },
    opts = {
      view = {
        width = 45,
        signcolumn = "yes",
      },
      renderer = {
        icons = {
          webdev_colors = true,
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      git = {
        enable = true,
        ignore = true,
        timeout = 400,
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
        },
        open_file = {
          quit_on_open = true,
          resize_window = false,
          window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
      }
    }
  },

  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    dependencies = {
      'f-person/git-blame.nvim',
    },
    config = function()
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

        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            'branch',
            { 'filename', file_status = false, path = 1 },
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
          lualine_y = { 'encoding', 'filetype' },
          -- lualine_z = { '%l:%c', '%p%%/%L' },
        }
      })
    end
  },


  {
    "terrortylor/nvim-comment",
    config = function()
      require('nvim_comment').setup({
        --create_mappings = false,
        line_mapping = "<leader>cl",
        operator_mapping = "<leader>c",
        comment_chunk_text_object = "ic"
      })
    end
  },
  "Djancyp/better-comments.nvim",


}
