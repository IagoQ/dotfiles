require('dap-go').setup()

vim.diagnostic.config({})

neotest = require("neotest")
neotest.setup({
  adapters = {
    require("neotest-go")({
      experimental = {
        test_table = true,
      }
    })
  }
})


