
" remove highlights after /
nnoremap <esc> :noh<return><esc>

" save on ctrls s
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" NERDTree
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" lsp 

"  nnoremap gD <Cmd>lua vim.lsp.buf.declaration()<CR>
"  nnoremap gd <Cmd>lua vim.lsp.buf.definition()<CR>
"  nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
"  nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>

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
nnoremap <leader>g <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>e <cmd>lua require('telescope.builtin').oldfiles()<cr>

nnoremap gd <cmd>lua require'telescope.builtin'.lsp_definitions{}<cr>
nnoremap gv <cmd>lua require'telescope.builtin'.lsp_definitions{jump_type="vsplit"}<cr>
nnoremap gi <cmd>lua require'telescope.builtin'.lsp_implementations{}<cr>
nnoremap gr <cmd>lua require'telescope.builtin'.lsp_references{}<cr>
nnoremap gs <cmd>lua require'telescope.builtin'.lsp_document_symbols{}<cr>
nnoremap gm <cmd>lua require'telescope.builtin'.lsp_document_symbols{symbols="method"}<cr>
nnoremap gw :Telescope diagnostics bufnr=0<cr>

