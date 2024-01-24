local fn = vim.fn

-- autoinstall lazynvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
  "folke/neodev.nvim",

  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-ui-select.nvim',

  'kyazdani42/nvim-web-devicons',
  'kyazdani42/nvim-tree.lua',

  'nvim-lualine/lualine.nvim',
  'kyazdani42/nvim-web-devicons',
  'f-person/git-blame.nvim',
  "SmiteshP/nvim-navic",

  'kdheepak/lazygit.nvim',
  "lewis6991/gitsigns.nvim",

  'ThePrimeagen/harpoon',

  'rcarriga/neotest',
  'nvim-neotest/neotest-go',

  'nvim-treesitter/nvim-treesitter',
  'nvim-treesitter/nvim-treesitter-textobjects',
  'nvim-treesitter/nvim-treesitter-context',
  'RRethy/nvim-treesitter-textsubjects',
  "terrortylor/nvim-comment",
  "Djancyp/better-comments.nvim",

  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'nvimtools/none-ls.nvim',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-nvim-lsp-signature-help',

  'saadparwaiz1/cmp_luasnip',
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',


  'navarasu/onedark.nvim',
  { "catppuccin/nvim", as = "catppuccin" },
  'folke/tokyonight.nvim',
  'wuelnerdotexe/vim-enfocado',
  {'nyoom-engineering/oxocarbon.nvim'},
})

