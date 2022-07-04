" remove highlights after /
nnoremap <esc> :noh<return><esc>

" save on ctrls s
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" NERDTree & terminal
nnoremap <C-f> :NvimTreeToggle <CR>
nnoremap <C-t> :belowright split <CR> :terminal <CR>:resize 15<CR><S-a>
" remove line numbers from terminal
autocmd TermOpen * setlocal nonumber norelativenumber

" escape terminal
tnoremap <Esc> <c-\><c-n>
tnoremap <C-o> <c-\><c-n><c-o>
tnoremap <C-t> <c-\><c-n>:bd!<CR>
tnoremap <C-w><C-c> <c-\><c-n>:bd!<CR>
tnoremap <C-w><C-i> <c-\><c-n><c-w><c-i>
tnoremap <C-w><C-j> <c-\><c-n><c-w><c-j>
tnoremap <C-w><C-k> <c-\><c-n><c-w><c-k>
tnoremap <C-w><C-l> <c-\><c-n><c-w><c-l>

" bufferline 
nnoremap <silent> gb :BufferLinePick<CR>
nnoremap <silent> gB :BufferLinePickClose<CR>

" lsp 
nnoremap K <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>f <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>e <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <leader>a <cmd>lua require'telescope.builtin'.lsp_code_actions()<cr>

" test
nnoremap <silent> <leader>tt :lua require("neotest").summary.toggle()<CR>
nnoremap <silent> <leader>tn :lua require("neotest").run.run({extra_args = {"-race"}})<CR>
nnoremap <silent> <leader>tf :lua require("neotest").run.run({vim.fn.expand("%"), extra_args = {"-race"}})<CR>
nnoremap <silent> <leader>ta :lua require('neotest').run.run({vim.fn.getcwd(), extra_args = {"-race"}})<CR>

" comment
nnoremap <silent> <leader>cl <Plug>(comment_toggle_current_linewise)
nnoremap <silent> <leader>c <Plug>(comment_toggle_linewise)
vnoremap <silent> <leader>c <Plug>(comment_toggle_linewise_visual)

" Mapings: telescope
nnoremap s <Nop>
nnoremap sf <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap sa <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap sb <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
nnoremap sh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap so <cmd>lua require('telescope.builtin').oldfiles()<cr>


nnoremap gd <cmd>lua require'telescope.builtin'.lsp_definitions{}<cr>
nnoremap gv <cmd>lua require'telescope.builtin'.lsp_definitions{jump_type="vsplit"}<cr>
nnoremap gi <cmd>lua require'telescope.builtin'.lsp_implementations{}<cr>
nnoremap gr <cmd>lua require'telescope.builtin'.lsp_references{}<cr>
nnoremap gs <cmd>lua require'telescope.builtin'.lsp_document_symbols{}<cr>
nnoremap gm <cmd>lua require'telescope.builtin'.lsp_document_symbols{symbols="method"}<cr>
nnoremap gw :Telescope diagnostics bufnr=0<cr>

