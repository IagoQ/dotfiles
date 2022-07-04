vim.cmd([[
  if has("nvim")
    let g:plug_home = stdpath('data') . '/plugged'
  endif

  call plug#begin()

  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'

  if has("nvim")
    " fuzzy finder
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'folke/trouble.nvim'
    
    " file explorer
    Plug 'kyazdani42/nvim-web-devicons' " for file icons
    Plug 'kyazdani42/nvim-tree.lua'
    
    " status line
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'f-person/git-blame.nvim'
    Plug 'kyazdani42/nvim-web-devicons'

    " bufferline
    Plug 'akinsho/bufferline.nvim'

    " movement
    Plug 'phaazon/hop.nvim'

    " test 
    Plug 'vim-test/vim-test' 

    Plug 'rcarriga/neotest'
    Plug 'nvim-neotest/neotest-go'

    Plug 'mfussenegger/nvim-dap'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'leoluz/nvim-dap-go'
    Plug 'antoinemadec/FixCursorHold.nvim'

    " syntax stuff
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
    Plug 'neovim/nvim-lspconfig'
    Plug 'windwp/nvim-autopairs'

    Plug 'numToStr/comment.nvim'

    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'L3MON4D3/LuaSnip'

    Plug 'rafamadriz/friendly-snippets'

    
    " themes 
    " Dracula Theme
    Plug 'Mofiqul/dracula.nvim'

    " Carbon theme
    Plug 'michaeldyrynda/carbon'

    " One Dark Pro Theme
    Plug 'olimorris/onedarkpro.nvim'

    " Inspired Github Theme
    Plug 'mvpopuk/inspired-github.vim'

    " Iceberg Theme
    Plug 'cocopon/iceberg.vim'
  endif
  call plug#end()
]])

