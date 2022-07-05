vim.cmd([[
autocmd BufWritePre *.go lua goimports()
autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
autocmd TermOpen * setlocal nonumber norelativenumber
]])
