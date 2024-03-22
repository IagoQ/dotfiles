return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  lazy = false,
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    -- { 'j-hui/fidget.nvim', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
    'nvimtools/none-ls.nvim',
  },
  config = function()
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      -- document-color.nvim
      local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
      end

      local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
      end

      -- Enable completion triggered by <c-x><c-o>
      buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

      -- Mappings.
      local opts = { noremap = true, silent = true }

      buf_set_keymap("n", "gd", "<cmd>lua require'telescope.builtin'.lsp_definitions{}<CR>", opts)
      buf_set_keymap("n", "gvd", "<cmd>lua require'telescope.builtin'.lsp_definitions{jump_type='vsplit'}<CR>", opts)
      buf_set_keymap("n", "gD", "<cmd>lua require'telescope.builtin'.lsp_type_definitions{}<CR>", opts)
      buf_set_keymap("n", "gvD", "<cmd>lua require'telescope.builtin'.lsp_type_definitions{jump_type='vsplit'}<CR>", opts)

      buf_set_keymap("n", "gi", "<cmd>lua require'telescope.builtin'.lsp_implementations{}<CR>", opts)
      buf_set_keymap("n", "gr", "<cmd>lua require'telescope.builtin'.lsp_references{}<CR>", opts)
      buf_set_keymap("n", "gs", "<cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>", opts)

      buf_set_keymap("n", "gw", ":Telescope diagnostics<CR>", opts)

      buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
      buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
      buf_set_keymap("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

      buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
      buf_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting({ async = true })<CR>", opts)

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*" },
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end

    local servers = {
      -- LSP
      "bashls",
      "clangd",
      "dockerls",
      "gopls",
      "jsonls",
      "rust_analyzer",
      "lua_ls",
      "yamlls",
      "solargraph"
    }


    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_installation = true,
    })


    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.golangci_lint
      },
    })


    for _, name in ipairs(servers) do
      local ok, server = require('lspconfig')[name].setup({
        on_attach = on_attach,
      })
    end

    -- document-color.nvim
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- You are now capable!
    capabilities.textDocument.colorProvider = true
  end
}
