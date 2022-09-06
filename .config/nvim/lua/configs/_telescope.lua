local telescope = require("telescope")
local actions = require("telescope.actions")


telescope.setup {
  defaults = {
    shorten_path = { true },
    preview = { true },
    file_ignore_patterns = { 'node_modules', 'vendor' },
  },
  pickers = {
      find_files = {
        prompt_title = 'All Files',
  --      theme = 'dropdown',
      },
      current_buffer_fuzzy_find = {
        prompt_title = 'Current buffer',
        sorting_strategy = 'descending'
      },
      oldfiles = {
          sort_lastused = true,
          prompt_title = "Recently Opened",
      },
      buffers = {
        sort_lastused = true,
        mappings = {
          i = {
            ["<c-d>"] = "delete_buffer",
          }
        }
      } 
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {
          -- even more opts
        }}
    }
}


telescope.load_extension("ui-select")
telescope.load_extension("refactoring")
