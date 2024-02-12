return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    opts = {
      -- One of "all", "maintained" (parsers with maintainers), or a list of languages
      -- Install languages synchronously (only applied to `ensure_installed`)
      sync_install = false,

      auto_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
        disable = { "text" , "nvim-tree"},
      },
      indent = {
        enable = false
      },
      ensure_installed = {
        "go",
        "yaml",
        "vim",
        "c",
        "haskell",
        "lua",
        "json",
        "typescript",
      }
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    },
  'nvim-treesitter/nvim-treesitter-context',
}
