function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = false })
end

-- window navigation
map("n","<C-h>", "<C-w>h")
map("n","<C-j>", "<C-w>j")
map("n","<C-k>", "<C-w>k")
map("n","<C-l>", "<C-w>l")

-- resize with arrow
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

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

-- escape terminal
map("t","<C-o>","<c-\\><c-n><c-o>")
map("t","<C-t>","<c-\\><c-n>:bd!<CR>")

map("t", "<C-h>", "<C-\\><C-N><C-w>h")
map("t", "<C-j>", "<C-\\><C-N><C-w>j")
map("t", "<C-k>", "<C-\\><C-N><C-w>k")
map("t", "<C-l>", "<C-\\><C-N><C-w>l")


-- bufferline 
map("n","gb",":BufferLinePick<CR>")
map("n","gB",":BufferLinePickClose<CR>")

-- lsp 
map("n","K","<Cmd>lua vim.lsp.buf.hover()<CR>")
map("n","<leader>rn","<cmd>lua vim.lsp.buf.rename()<CR>")
map("n","<leader>f","<cmd>lua vim.lsp.buf.formatting()<CR>")
map("n","<leader>e","<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
map("n","<leader>a","<cmd>lua vim.lsp.buf.code_action()<CR>")

-- test
map("n","<leader>tt",":lua require('neotest').summary.toggle()<CR>")
map("n","<leader>tn",":lua require('neotest').run.run({extra_args = {'-race'}})<CR>")
map("n","<leader>tf",":lua require('neotest').run.run({vim.fn.expand('%'), extra_args = {'-race'}})<CR>")
map("n","<leader>ta",":lua require('neotest').run.run({vim.fn.getcwd(), extra_args = {'-race'}})<CR>")
map("n","<leader>ta",":lua require('neotest').run.run({vim.fn.getcwd(), extra_args = {'-race'}})<CR>")

-- TODO: fixme
-- vim.keymap.set('n', '<Leader>tc', require("nvim-goc").Coverage, {silent=true})
-- vim.keymap.set('n', '<Leader>tC', require("nvim-goc").ClearCoverage, {silent=true})

-- debugging
vim.keymap.set('n','<F7>', require("dap").step_out)
vim.keymap.set('n','<F8>', require("dap").step_into)
vim.keymap.set('n','<F9>', require("dap").step_over)
vim.keymap.set('n','<Leader>db', require("dap").toggle_breakpoint)
vim.keymap.set('n','<Leader>dt', require("dap-go").debug_test)


-- Mapings: telescope
map("n","s","<Nop>")
map("n","sf","<cmd>lua require('telescope.builtin').find_files()<CR>")
map("n","sa","<cmd>lua require('telescope.builtin').live_grep()<CR>")
map("n","sb","<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
map("n","sh","<cmd>lua require('telescope.builtin').help_tags()<CR>")
map("n","so","<cmd>lua require('telescope.builtin').oldfiles()<CR>")


-- go to's
map("n","gd","<cmd>lua require'telescope.builtin'.lsp_definitions{}<CR>")
map("n","gv","<cmd>lua require'telescope.builtin'.lsp_definitions{jump_type='vsplit'}<CR>")
map("n","gi","<cmd>lua require'telescope.builtin'.lsp_implementations{}<CR>")
map("n","gr","<cmd>lua require'telescope.builtin'.lsp_references{}<CR>")
map("n","gs","<cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>")
map("n","gm","<cmd>lua require'telescope.builtin'.lsp_document_symbols{symbols='method'}<CR>")
map("n","gw",":Telescope diagnostics bufnr=0<CR>")



-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
	"v",
	"<leader>rr",
	"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
	{ noremap = true }
)
-- Remaps for the refactoring operations currently offered by the plugin
vim.api.nvim_set_keymap("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})

-- Extract block doesn't need visual mode
vim.api.nvim_set_keymap("n", "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]], {noremap = true, silent = true, expr = false})

-- Inline variable can also pick up the identifier currently under the cursor without visual mode
vim.api.nvim_set_keymap("n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})
