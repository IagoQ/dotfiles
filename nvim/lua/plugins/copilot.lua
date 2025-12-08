return {
  --   {
  --     "zbirenbaum/copilot.lua",
  --     dependencies = {
  --       "hrsh7th/nvim-cmp",
  --     },
  --     cmd = "Copilot",
  --     build = ":Copilot auth",
  --     event = "InsertEnter",
  --     config = function()
  --       require("copilot").setup({
  --         panel = {
  --           enabled = true,
  --           auto_refresh = false,
  --           keymap = {
  --             jump_prev = "<C-p>",
  --             jump_next = "<C-n>",
  --             accept = "<C-k>",
  --             refresh = "gr",
  --             -- open = false
  --           },
  --           layout = {
  --             position = "bottom", -- | top | left | right
  --             ratio = 0.4
  --           },
  --         },
  --         suggestion = {
  --           enabled = true,
  --           auto_trigger = false,
  --           debounce = 50,
  --           keymap = {
  --             accept = "<C-k>",
  --             accept_word = false,
  --             accept_line = false,
  --             next = "<C-n>",
  --             prev = "<C-p>",
  --             dismiss = "<C-e>",
  --           },
  --         },
  --       })
  --
  --       function open_panel()
  --         require("copilot.panel").open({ "bottom", 0.4 })
  --       end
  --
  --       vim.keymap.set("n", "<leader>cp", open_panel)
  --
  --       -- hide copilot suggestions when cmp menu is open
  --       -- to prevent odd behavior/garbled up suggestions
  --       -- local cmp_status_ok, cmp = pcall(require, "cmp")
  --       -- if cmp_status_ok then
  --       --   cmp.event:on("menu_opened", function()
  --       --     vim.b.copilot_suggestion_hidden = true
  --       --   end)
  --       --
  --       --   cmp.event:on("menu_closed", function()
  --       --     vim.b.copilot_suggestion_hidden = false
  --       --   end)
  --       -- end
  --     end,
  --   },
  --   {
  --     "zbirenbaum/copilot-cmp",
  --     config = function()
  --       require("copilot_cmp").setup()
  --     end,
  --   },
  {
    "folke/sidekick.nvim",
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
      },
    },
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<leader>aa",
        function() require("sidekick.cli").toggle() end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>as",
        function() require("sidekick.cli").select() end,
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = "Select CLI",
      },
      {
        "<leader>at",
        function() require("sidekick.cli").send({ msg = "{this}" }) end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>av",
        function() require("sidekick.cli").send({ msg = "{selection}" }) end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<leader>ap",
        function() require("sidekick.cli").prompt() end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
      {
        "<c-.>",
        function() require("sidekick.cli").focus() end,
        mode = { "n", "x", "i", "t" },
        desc = "Sidekick Switch Focus",
      },
      -- Example of a keybinding to open Claude directly
      {
        "<leader>ac",
        function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
        desc = "Sidekick Toggle Claude",
      },
    },
  }
}
