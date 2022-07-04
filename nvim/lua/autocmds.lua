
vim.api.nvim_createautocmd({ "TermOpen"}, { pattern = "*", command = " setlocal nonumber norelativenumber"})
-- autocmd TermOpen * setlocal nonumber norelativenumber
