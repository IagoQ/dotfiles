return {
  {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      indent = { enabled = false },
      input = { enabled = true },
      quickfile = { enabled = true },
      picker = {
        enabled = true,
        layout = {
          cycle = false,
        },
        matcher = {
          frecency = true,
        },
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
          },
        },
      },
      notifier = {
        enabled = true,
        top_down = false, -- place notifications from top to bottom
      },
      lazygit = {
        win = {
          width = 0,
          height = 0,
        },
      },
    },
    keys = {
      { "<C-g>",     function() Snacks.lazygit() end },
      -- find
      { "sm",        function() Snacks.picker.smart() end,                                                  desc = "Find Files" },
      { "sf",        function() Snacks.picker.files() end,                                                  desc = "Find Files" },
      { "sg",        function() Snacks.picker.git_files() end,                                              desc = "Find Git Files" },
      { "so",        function() Snacks.picker.recent() end,                                                 desc = "Recent" },
      -- Grep
      { "sb",        function() Snacks.picker.lines() end,                                                  desc = "Buffer Lines" },
      { "sB",        function() Snacks.picker.buffers() end,                                                desc = "Grep Open Buffers" },
      { "sa",        function() Snacks.picker.grep() end,                                                   desc = "Grep" },
      { "sw",        function() Snacks.picker.grep_word() end,                                              desc = "Visual selection or word", mode = { "n", "x" } },
      -- comments
      { "st",        function() Snacks.picker.todo_comments() end,                                          desc = "Todo" },
      { "sT",        function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
      -- search
      { "sh",        function() Snacks.picker.help() end,                                                   desc = "Help Pages" },
      { "sj",        function() Snacks.picker.jumps() end,                                                  desc = "Jumps" },
      { "sq",        function() Snacks.picker.qflist() end,                                                 desc = "Quickfix List" },
      { "<leader>p", function() Snacks.picker.projects() end,                                               desc = "Projects" },
      -- LSP
      { "gd",        function() Snacks.picker.lsp_definitions() end,                                        desc = "Goto Definition" },
      { "gD",        function() Snacks.picker.lsp_type_definitions() end,                                   desc = "Goto T[y]pe Definition" },
      { "gr",        function() Snacks.picker.lsp_references() end,                                         nowait = true,                     desc = "References" },
      { "gi",        function() Snacks.picker.lsp_implementations() end,                                    desc = "Goto Implementation" },
      { "gs",        function() Snacks.picker.lsp_symbols() end,                                            desc = "LSP Symbols" },
      { "gS",        function() Snacks.picker.lsp_workspace_symbols() end,                                  desc = "LSP Workspace Symbols" },
      { "gw",        function() Snacks.picker.diagnostics() end,                                            desc = "Diagnostics" },
    },
  },
}
