" Fundamentals "{{{
" ---------------------------------------------------------------------

" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8
" stop loading config if it's on tiny or small
if !1 | finish | endif

  
set nocompatible
set number
syntax enable
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=utf-8
set title
set autoindent
set background=dark
set nobackup
set hlsearch
set showcmd
set cmdheight=1
set laststatus=2
set scrolloff=10
set expandtab
"let loaded_matchparen = 1
"  set shell=fish
set backupskip=/tmp/*,/private/tmp/*

" incremental substitution (neovim)
if has('nvim')
  set inccommand=split
endif

" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=

set nosc noru nosm
" Don't redraw while executing macros (good performance config)
set lazyredraw
"set showmatch
" How many tenths of a second to blink when matching brackets
"set mat=2
" Ignore case when searching
set ignorecase
" Be smart when using tabs ;)
set smarttab
" indents
filetype plugin indent on
set shiftwidth=2
set tabstop=2
set ai "Auto indent
set si "Smart indent
set nowrap "No Wrap lines
set backspace=start,eol,indent

" Finding files - Search down into subfolders
set path+=**
set wildignore+=*/node_modules/*

"  disable upper buffer omnifunc
set completeopt-=preview

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" Add asterisks in block comments
set formatoptions+=r

"}}}


" Imports "{{{
" ---------------------------------------------------------------------

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
  Plug 'preservim/nerdtree'
  
  " status line
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'f-person/git-blame.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  
  " syntax stuff
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'neovim/nvim-lspconfig'
  Plug 'windwp/nvim-autopairs'

  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'L3MON4D3/LuaSnip'

  
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

Plug 'groenewege/vim-less', { 'for': 'less' }


call plug#end()

if has("unix")
  let s:uname = system("uname -s")
  " Do Mac stuff
  if s:uname == "Darwin\n"
    runtime ./macos.vim
  endif
endif
if has('win32')
  runtime ./windows.vim
endif

runtime ./maps.vim
"}}}

" UI "{{{
" ---------------------------------------------------------------------

lua require("_lualine")

"}}}

" language things "{{{
" ---------------------------------------------------------------------
" golang
lua require("treesitter")

lua require("lsp_config")

lua require("_telescope")

lua require("completition")



autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
autocmd BufWritePre *.go lua goimports(1000)

"}}}


" NERDTree "{{{
" ---------------------------------------------------------------------
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"  }}}}




" theme "{{{
" ---------------------------------------------------------------------
source ~/.config/nvim/theme.vim
"}}}

" vim: set foldmethod=marker foldlevel=0:
