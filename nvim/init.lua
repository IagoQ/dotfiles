

vim.cmd([[
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
set ignorecase
set smarttab
set shiftwidth=2
set tabstop=2
set ai "Auto indent
" set si "Smart indent
set lazyredraw
set noswapfile
]])

require("plugins")
require("maps")
require("configs")
require("autocmds")


require('onedark').setup {
    style = 'dark' -- Dark, Darker, Cool, Deep, Warm, Warmer
}
require('onedark').load()


