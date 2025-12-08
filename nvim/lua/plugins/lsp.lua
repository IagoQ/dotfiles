return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
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
    local servers = {
      -- LSP
      -- "bashls",
      "clangd",
      -- "dockerls",
      "gopls",
      "jsonls",
      "rust_analyzer",
      "lua_ls",
      "pyright",
      "ts_ls",
      -- "yamlls",
      -- "lemminx"
      -- "solargraph",
      -- "r_language_server"
      "pbls"
    }

    require("mason").setup()
    require('neodev').setup({})

    local lspconfig = require('lspconfig')

    local lsp_settings = {
      pyright = {
        python = {
          pythonPath = vim.fn.trim(vim.fn.system("pyenv which python"))
        }
      }
    }

    -- Configure capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.colorProvider = true
    capabilities = vim.tbl_extend('keep', capabilities, require('cmp_nvim_lsp').default_capabilities())

    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_installation = true,
      handlers = {
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            settings = lsp_settings[server_name]
          })
        end,
      },
    })

    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.golangci_lint.with({
          extra_args = { "--fast" },
        }),
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports,
      },
    })
  end
  }
}
