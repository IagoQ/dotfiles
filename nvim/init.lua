vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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

require("lazy").setup("plugins")

vim.o.number = true
vim.o.hlsearch = true
vim.o.laststatus = 3
vim.o.scrolloff = 8
vim.o.relativenumber = true
vim.o.smartcase = true
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.lazyredraw = true
vim.o.swapfile = false
vim.o.display = 'lastline'
vim.o.clipboard = 'unnamedplus'
vim.o.undofile = true
vim.o.cmdheight = 0
vim.opt.pumheight = 4

require("maps")

vim.diagnostic.config({
  virtual_text = {
    virt_text_pos = "eol",
    spacing = 16,
  },
  signs = false,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})
