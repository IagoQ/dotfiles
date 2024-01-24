function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = false })
end

-- , and Tab are free 

-- window navigation map("n","<C-h>", "<C-w>h")
map("n","<C-j>", "<C-w>j")
map("n","<C-k>", "<C-w>k")
map("n","<C-l>", "<C-w>l")

-- resize with arrow
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Copy/paste to clipboard
map("v","<leader>y",  "\"+y")
map("n","<leader>y",  "\"+y")
map("v","<leader>p",  "\"+p")
map("n","<leader>p",  "\"+p")

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
map("n","<C-g>",":LazyGit <CR>")
-- map("n","<C-t>",":belowright split <CR> :terminal <CR>:resize 15<CR><S-a>")

-- test
map("n","<leader>tt",":lua require('neotest').summary.toggle()<CR>")
map("n","<leader>tp",":lua require('neotest').output_panel.toggle()<CR>")
map("n","<leader>tn",":lua require('neotest').run.run({extra_args = {'-race'}})<CR>")
map("n","<leader>tf",":lua require('neotest').run.run({vim.fn.expand('%'), extra_args = {'-race'}})<CR>")
map("n","<leader>tf",":lua require('neotest').run.run({vim.fn.expand('%'), extra_args = {'-race'}})<CR>")
map("n","<leader>ta",":lua require('neotest').run.run({vim.fn.getcwd(), extra_args = {'-race'}})<CR>")

-- Mapings: telescope
map("n","s","<Nop>")
map("n","sf","<cmd>lua require('telescope.builtin').find_files()<CR>")
map("n","sa","<cmd>lua require('telescope.builtin').live_grep()<CR>")
map("n","sb","<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
map("n","sh","<cmd>lua require('telescope.builtin').help_tags()<CR>")
map("n","so","<cmd>lua require('telescope.builtin').oldfiles()<CR>")
map("n","sq","<cmd>lua require('telescope.builtin').quickfix()<CR>")
map("n","sj","<cmd>lua require('telescope.builtin').jumplist()<CR>")

map("n",",","<Nop>")
-- harpoon
map("n",";","<Nop>")
vim.keymap.set("n", ";;", require("harpoon.ui").toggle_quick_menu)
vim.keymap.set("n", ";l", require("harpoon.mark").add_file)
vim.keymap.set("n", ";k", require("harpoon.ui").nav_prev)
vim.keymap.set("n", ";j", require("harpoon.ui").nav_next)
vim.keymap.set("n", ";1", function() require("harpoon.ui").nav_file(1) end)
vim.keymap.set("n", ";2", function() require("harpoon.ui").nav_file(2) end)
vim.keymap.set("n", ";3", function() require("harpoon.ui").nav_file(3) end)
vim.keymap.set("n", ";4", function() require("harpoon.ui").nav_file(4) end)
vim.keymap.set("n", ";5", function() require("harpoon.ui").nav_file(5) end)
vim.keymap.set("n", ";6", function() require("harpoon.ui").nav_file(6) end)
vim.keymap.set("n", ";7", function() require("harpoon.ui").nav_file(7) end)
vim.keymap.set("n", ";8", function() require("harpoon.ui").nav_file(8) end)
vim.keymap.set("n", ";9", function() require("harpoon.ui").nav_file(9) end)

