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
  "folke/which-key.nvim",
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

  'akinsho/bufferline.nvim',

  'rcarriga/neotest',
  'nvim-neotest/neotest-go',

  'mfussenegger/nvim-dap',
  'leoluz/nvim-dap-go',
  'rcarriga/nvim-dap-ui',
  'nvim-telescope/telescope-dap.nvim',
  'theHamsta/nvim-dap-virtual-text',
  'antoinemadec/FixCursorHold.nvim',

  'nvim-treesitter/nvim-treesitter',
  'nvim-treesitter/nvim-treesitter-context',
  'windwp/nvim-autopairs',
  "terrortylor/nvim-comment",
  "Djancyp/better-comments.nvim",

  "ThePrimeagen/refactoring.nvim",

  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'jose-elias-alvarez/null-ls.nvim',
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
