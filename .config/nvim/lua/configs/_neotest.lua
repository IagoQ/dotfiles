neotest = require("neotest")
neotest.setup({
  -- consumers = {
  --
  --   always_open_output = function(client)
  --     local async = require("neotest.async")
  --
  --     client.listeners.results = function(adapter_id, results)
  --       local file_path = async.fn.expand("%:p")
  --       local row = async.fn.getpos(".")[2] - 1
  --       local position = client:get_nearest(file_path, row, {})
  --       if not position then
  --         return
  --       end
  --       local pos_id = position:data().id
  --       if not results[pos_id] then
  --         return
  --       end
  --       neotest.output.open({ position_id = pos_id, adapter = adapter_id })
  --     end
  --   end,
  -- },
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
    open = false
  },
  output = {
    enabled = false
  },
})
