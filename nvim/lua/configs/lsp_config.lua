local nvim_lsp = require('lspconfig')
local protocol = require('vim.lsp.protocol')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.diagnostic.config({
  virtual_text = true,
  signs = false,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- https://github.com/windwp/nvim-autopairs
require('nvim-autopairs').setup()

-- c/c++
nvim_lsp.clangd.setup{
  cmd = {
            "clangd",
            "--background-index",
            "--suggest-missing-includes",
        },  
	capabilities = capabilities,
  on_attach = on_attach,
}

-- haskell
nvim_lsp.hls.setup {
  settings = {
    haskell = {
      formattingProvider = 'stylish-haskell',
    },
  },
  on_attach = on_attach,
}

-- golang
nvim_lsp.gopls.setup{
	cmd = {'gopls'},
	-- for postfix snippets and analyzers
	capabilities = capabilities,
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
     },
     staticcheck = true,
    },
  },
  on_attach = on_attach,
}

