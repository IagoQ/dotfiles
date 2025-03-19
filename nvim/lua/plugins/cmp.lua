return {
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp-signature-help',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
    config = function()
      -- luasnip setup
      require("luasnip.loaders.from_vscode").lazy_load()

      local luasnip = require("luasnip")

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end


      -- nvim-cmp setup
      local cmp = require 'cmp'
      cmp.setup({
        window = {
          border = 'rounded',
          documentation = {
            border = 'rounded',
          }
        },
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        completion = {
          -- autocomplete = false,
          keyword_length = 0,
        },
        preselect = cmp.PreselectMode.None,
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              cmp.complete()
            end
          end, { "i", "s" }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
          },
          -- ["<Tab>"] = cmp.mapping.confirm {
          --   behavior = cmp.confirmbehavior.insert,
          --   select = true,
          -- },
          ['<Tab>'] = cmp.mapping(function(fallback)
            -- local copilot = require 'copilot.suggestion'
            -- if copilot.is_visible() then
            --   copilot.accept()
            -- elseif cmp.visible() then
            if cmp.visible() then
              local entry = cmp.get_selected_entry()
              if not entry then
                cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
                cmp.confirm({
                  behavior = cmp.ConfirmBehavior.Insert,
                  select = false,
                })
              else
                cmp.confirm({
                  behavior = cmp.ConfirmBehavior.Insert,
                  select = false,
                })
              end
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),

        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'nvim_lsp_signature_help' }
        },

        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.locality,
            cmp.config.compare.recently_used,

            -- copied from cmp-under, but I don't think I need the plugin for this.
            -- I might add some more of my own.
            function(entry1, entry2)
              local _, entry1_under = entry1.completion_item.label:find "^_+"
              local _, entry2_under = entry2.completion_item.label:find "^_+"
              entry1_under = entry1_under or 0
              entry2_under = entry2_under or 0

              if entry1_under > entry2_under then
                return false
              elseif entry1_under < entry2_under then
                return true
              end
            end,

            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        experimental = {
          ghost_text = true,
        },
      })
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
    end
  },
  -- {
  --   'saghen/blink.cmp',
  --   -- optional: provides snippets for the snippet source
  --   dependencies = 'rafamadriz/friendly-snippets',
  --   version = '*',
  --
  --   opts = {
  --     -- 'default' for mappings similar to built-in completion
  --     -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
  --     -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
  --     -- See the full "keymap" documentation for information on defining your own keymap.
  --     keymap = {
  --       -- set to 'none' to disable the 'default' preset
  --       preset = 'enter',
  --
  --       ['<Tab>'] = {
  --         function(cmp)
  --           if cmp.snippet_active() then
  --             return cmp.accept()
  --           else
  --             return cmp.select_and_accept()
  --           end
  --         end,
  --         'snippet_forward',
  --         'fallback'
  --       },
  --       ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
  --
  --       -- ['<C-p>'] = { 'select_prev', 'fallback' },
  --       -- ['<C-n>'] = { 'select_next', 'fallback' },
  --     },
  --
  --     appearance = {
  --       -- Sets the fallback highlight groups to nvim-cmp's highlight groups
  --       -- Useful for when your theme doesn't support blink.cmp
  --       -- Will be removed in a future release
  --       use_nvim_cmp_as_default = true,
  --       -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
  --       -- Adjusts spacing to ensure icons are aligned
  --       nerd_font_variant = 'mono'
  --     },
  --
  --     completion = {
  --       -- 'prefix' will fuzzy match on the text before the cursor
  --       -- 'full' will fuzzy match on the text before *and* after the cursor
  --       -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
  --       keyword = { range = 'full' },
  --
  --       -- Disable auto brackets
  --       -- NOTE: some LSPs may add auto brackets themselves anyway
  --       accept = { auto_brackets = { enabled = false }, },
  --
  --       -- Insert completion item on selection, don't select by default
  --       list = { selection = 'preselect' },
  --
  --       -- Show documentation when selecting a completion item
  --       documentation = { auto_show = true, auto_show_delay_ms = 500 },
  --
  --       -- Display a preview of the selected item on the current line
  --       ghost_text = { enabled = true },
  --     },
  --
  --     signature = { enabled = true },
  --
  --
  --     -- Default list of enabled providers defined so that you can extend it
  --     -- elsewhere in your config, without redefining it, due to `opts_extend`
  --     sources = {
  --       default = { 'lsp', 'path', 'snippets', 'buffer' },
  --     },
  --
  --     enabled = function()
  --       return not vim.tbl_contains({ "lua", "markdown" }, vim.bo.filetype)
  --           and vim.bo.buftype ~= "prompt"
  --           and vim.b.completion ~= false
  --     end,
  --   },
  --   opts_extend = { "sources.default" }
  -- }
}
