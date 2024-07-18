function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = false })
end

-- resize with arrow
map("n", "<C-Up>", ":resize -2<CR>")

map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Copy/paste to clipboard
map("v", "<leader>p", "\"0p")
map("n", "<leader>p", "\"0p")

-- remove highlights after /
map("n", "<esc>", ":noh<return><esc>")

-- save on ctrls s
map("n", "<C-S>", ":wa!<CR>")
map("v", "<C-S>", "<Esc>:wa!<CR>")
map("i", "<C-S>", "<Esc>:wa!<CR>")

-- move lines
map("n", "<A-j>", ":m .+1<CR>")
map("n", "<A-k>", ":m .-2<CR>")
map("i", "<A-j>", "<Esc>:m .+1<CR>")
map("i", "<A-k>", "<Esc>:m .-2<CR>")
map("v", "<A-j>", ":m '>+1<CR>gv")
map("v", "<A-k>", ":m '<-2<CR>gv")

-- NERDTree & terminal
map("n", "<C-f>", ":NvimTreeToggle <CR>")
map("n", "<C-g>", ":LazyGit <CR>")
-- map("n","<C-t>",":belowright split <CR> :terminal <CR>:resize 15<CR><S-a>")

-- Mapings: telescope
map("n", "s", "<Nop>")
map("v", "s", "<Nop>")
map("n", "sf", "<cmd>lua require('telescope.builtin').find_files()<CR>")
map("n", "sa", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
map("n", "sb", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
map("n", "sh", "<cmd>lua require('telescope.builtin').help_tags()<CR>")
map("n", "so", "<cmd>lua require('telescope.builtin').oldfiles()<CR>")
map("n", "sq", "<cmd>lua require('telescope.builtin').quickfix()<CR>")
map("n", "sj", "<cmd>lua require('telescope.builtin').jumplist()<CR>")
map("n", "su", "<cmd>Telescope undo<cr>")
map("n", "sw", "<cmd>lua require('telescope.builtin').grep_string()<CR>")
map("v", "sw", "<cmd>lua require('telescope.builtin').grep_string()<CR>")

-- cody
map("v", "<leader>;a", ":CodyAsk <CR>")
map("v", "<leader>;e", ":CodyExplain <CR>")
map("v", "<leader>;t", ":CodyTask <CR>")
map("n", "<leader>;e", ":CodyRestart <CR>")
map("n", "<leader>;c", ":CodyChat <CR>")


--quickfixlist
vim.keymap.set("n", "<leader>qn", ":cn<CR>")
vim.keymap.set("n", "<leader>qp", ":cp<CR>")
