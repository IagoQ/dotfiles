return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          disable = { "text", "nvim-tree" },
        },
        indent = {
          enable = false
        },
        ensure_installed = {
          "go",
          "yaml",
          "vim",
          "c",
          "markdown",
          "vimdoc",
          "lua",
          "json",
          "typescript",
          "tsx",
        },
        -- textobjects = {
        --   select = {
        --     enable = true,
        --     lookahead = true,
        --     keymaps = {
        --       ["af"] = "@function.outer",
        --       ["if"] = "@function.inner",
        --       ["ac"] = "@class.outer",
        --       ["ic"] = "@class.inner",
        --       ["as"] = "@local.scope",
        --     },
        --   },
        --   move = {
        --     enable = true,
        --     set_jumps = true,
        --     goto_next_start = {
        --       ["]m"] = "@function.outer",
        --       ["]]"] = { query = "@class.outer", desc = "Next class start" },
        --       ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
        --       ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
        --       ["]f"] = "@function.inner",
        --       ["]c"] = "@class.inner",
        --       ["]p"] = "@parameter.inner",
        --       ["]o"] = "@comment.outer",
        --     },
        --     goto_next_end = {
        --       ["]M"] = "@function.outer",
        --       ["]["] = "@class.outer",
        --       ["]F"] = "@function.inner",
        --       ["]C"] = "@class.inner",
        --       ["]P"] = "@parameter.inner",
        --       ["]O"] = "@comment.outer",
        --     },
        --     goto_previous_start = {
        --       ["[m"] = "@function.outer",
        --       ["[["] = "@class.outer",
        --       ["[f"] = "@function.inner",
        --       ["[c"] = "@class.inner",
        --       ["[p"] = "@parameter.inner",
        --       ["[o"] = "@comment.outer",
        --     },
        --     goto_previous_end = {
        --       ["[M"] = "@function.outer",
        --       ["[]"] = "@class.outer",
        --       ["[F"] = "@function.inner",
        --       ["[C"] = "@class.inner",
        --       ["[P"] = "@parameter.inner",
        --       ["[O"] = "@comment.outer",
        --     },
        --   },
        -- },
      })
    end,
  },
  'nvim-treesitter/nvim-treesitter-context',
}
