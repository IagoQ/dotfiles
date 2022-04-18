
" remove highlights after /
nnoremap <esc> :noh<return><esc>

" save on ctrls s
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" NERDTree & terminal
nnoremap <C-f> :NvimTreeToggle <CR>
nnoremap <C-t> :vsplit <CR> :terminal <CR>:vertical resize 60<CR><S-a>

" escape terminal
tnoremap <Esc> <c-\><c-n>
tnoremap <C-o> <c-\><c-n><c-o>
tnoremap <C-w><C-c> <c-\><c-n><c-w>c
tnoremap <C-w><C-i> <c-\><c-n><c-w><c-i>
tnoremap <C-w><C-j> <c-\><c-n><c-w><c-j>
tnoremap <C-w><C-k> <c-\><c-n><c-w><c-k>
tnoremap <C-w><C-l> <c-\><c-n><c-w><c-l>

" lsp 
nnoremap K <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <space>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <space>f <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <space>e <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <space>a <cmd>lua require'telescope.builtin'.lsp_code_actions()<cr>
"  nnoremap ga <Cmd>lua vim.lsp.buf.code_action()<CR>

nnoremap [d <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap ]d <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" Mappings: telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fl <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fo <cmd>lua require('telescope.builtin').oldfiles()<cr>

nnoremap gd <cmd>lua require'telescope.builtin'.lsp_definitions{}<cr>
nnoremap gv <cmd>lua require'telescope.builtin'.lsp_definitions{jump_type="vsplit"}<cr>
nnoremap gi <cmd>lua require'telescope.builtin'.lsp_implementations{}<cr>
nnoremap gr <cmd>lua require'telescope.builtin'.lsp_references{}<cr>
nnoremap gs <cmd>lua require'telescope.builtin'.lsp_document_symbols{}<cr>
nnoremap gm <cmd>lua require'telescope.builtin'.lsp_document_symbols{symbols="method"}<cr>
nnoremap gw :Telescope diagnostics bufnr=0<cr>

