return {
  'navarasu/onedark.nvim',
  {
    'folke/tokyonight.nvim',
    config = function()
      require("tokyonight").setup({
        -- use the night style
        style = "night",
      })
      -- vim.cmd("colorscheme tokyonight")
    end
  },
  'wuelnerdotexe/vim-enfocado',
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    config = function()
      -- Default options:
      require('kanagawa').setup({
        compile = false,   -- enable compiling the colorscheme
        undercurl = false, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,   -- do not set background color
        dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = {             -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors)
          return {
            -- Other highlight overrides
            ["@markup.link.label.tsx"] = { fg = colors.palette.carpYellow, underline = false },
          }
        end,
        theme = "wave",  -- Load "wave" theme when 'background' option is not set
        background = {   -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus"
        },
      })
      -- setup must be called before loading
      vim.cmd("colorscheme kanagawa")
    end
  },

}
