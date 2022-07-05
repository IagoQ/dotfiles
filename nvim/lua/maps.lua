function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

-- remove highlights after /
map("n", "<esc>", ":noh<return><esc>")

-- save on ctrls s
map("n","<C-S>",":update<CR>")
map("v","<C-S>","<C-C>:update<CR>")
map("i","<C-S>","<C-O>:update<CR>")

-- move lines

map("n","<A-j>",":m .+1<CR>==")
map("n","<A-k>",":m .-2<CR>==")
map("i","<A-j>","<Esc>:m .+1<CR>==")
map("i","<A-k>","<Esc>:m .-2<CR>==")
map("v","<A-j>",":m '>+1<CR>gv==")
map("v","<A-k>",":m '<-2<CR>gv==")

-- NERDTree & terminal
map("n","<C-f>",":NvimTreeToggle <CR>")
map("n","<C-t>",":belowright split <CR> :terminal <CR>:resize 15<CR><S-a>")
map("n","<C-g>",":LazyGit <CR>")

-- remove line numbers from terminal

-- escape terminal
map("t","<Esc>","<c-\\><c-n>")
map("t","<C-o>","<c-\\><c-n><c-o>")
map("t","<C-t>","<c-\\><c-n>:bd!<CR>")
map("t","<C-w><C-c>","<c-\\><c-n>:bd!<CR>")
map("t","<C-w><C-i>","<c-\\><c-n><c-w><c-i>")
map("t","<C-w><C-j>","<c-\\><c-n><c-w><c-j>")
map("t","<C-w><C-k>","<c-\\><c-n><c-w><c-k>")
map("t","<C-w><C-l>","<c-\\><c-n><c-w><c-l>")

-- bufferline 
map("n","gb",":BufferLinePick<CR>")
map("n","gB",":BufferLinePickClose<CR>")

-- lsp 
map("n","K","<Cmd>lua vim.lsp.buf.hover()<CR>")
map("n","<leader>rn","<cmd>lua vim.lsp.buf.rename()<CR>")
map("n","<leader>f","<cmd>lua vim.lsp.buf.formatting()<CR>")
map("n","<leader>e","<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
map("n","<leader>a","<cmd>lua require'telescope.builtin'.lsp_code_actions()<cr>")

-- test
map("n","<leader>tt",":lua require('neotest').summary.toggle()<CR>")
map("n","<leader>tn",":lua require('neotest').run.run({extra_args = {'-race'}})<CR>")
map("n","<leader>tf",":lua require('neotest').run.run({vim.fn.expand('%'), extra_args = {'-race'}})<CR>")
map("n","<leader>ta",":lua require('neotest').run.run({vim.fn.getcwd(), extra_args = {'-race'}})<CR>")

-- comment
map("n","<leader>cl","<Plug>(comment_toggle_current_linewise)")
map("n","<leader>c","<Plug>(comment_toggle_linewise)")
map("v","<leader>c","<Plug>(comment_toggle_linewise_visual)")

-- Mapings: telescope
map("n","s","<Nop>")
map("n","sf","<cmd>lua require('telescope.builtin').find_files()<CR>")
map("n","sa","<cmd>lua require('telescope.builtin').live_grep()<CR>")
map("n","sb","<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
map("n","sh","<cmd>lua require('telescope.builtin').help_tags()<CR>")
map("n","so","<cmd>lua require('telescope.builtin').oldfiles()<CR>")


map("n","gd","<cmd>lua require'telescope.builtin'.lsp_definitions{}<CR>")
map("n","gv","<cmd>lua require'telescope.builtin'.lsp_definitions{jump_type='vsplit'}<CR>")
map("n","gi","<cmd>lua require'telescope.builtin'.lsp_implementations{}<CR>")
map("n","gr","<cmd>lua require'telescope.builtin'.lsp_references{}<CR>")
map("n","gs","<cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>")
map("n","gm","<cmd>lua require'telescope.builtin'.lsp_document_symbols{symbols='method'}<CR>")
map("n","gw",":Telescope diagnostics bufnr=0<CR>")

