return {
  'mbbill/undotree',
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        }
      })

      vim.keymap.set("n", "<leader>;", function() harpoon:list():add() end)
      vim.keymap.set("n", "<leader><leader>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
      vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end)
      vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end)
      vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end)
      vim.keymap.set("n", "<leader>8", function() harpoon:list():select(8) end)
      vim.keymap.set("n", "<leader>9", function() harpoon:list():select(9) end)
    end,
  },
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
        ignore = false,
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
      vim.g.gitblame_message_template = '<date> • <author>'

      local function isRecording()
        local reg = vim.fn.reg_recording()
        if reg == "" then return "" end -- not recording
        return "recording to " .. reg
      end

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
          lualine_x = { isRecording, 'searchcount', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
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
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    opts = {},
  }
}
