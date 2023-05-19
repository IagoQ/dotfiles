neotest = require("neotest")
neotest.setup({
  adapters = {
    require("neotest-go")({
      experimental = {
        test_table = true,
      },
      args = { "-race", "-timeout=40s" }
    })
  },
  floating = {
    max_height = 400,
    max_width = 220,
  },
  running = {
    concurrent = true
  },
  quickfix = {
    enabled = true,
    open = false,
  },
  output = {
    enabled = false
  },
})
