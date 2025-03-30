return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  keys = {
    { "<leader>tt", "<Cmd>Neotree<cr>" },
  },
  opts = {
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      "document_symbols",
    },
  },
  config = function()
    require('neo-tree').setup({
      filesystem = {
        commands = {
          avante_add_files = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local relative_path = require('avante.utils').relative_path(filepath)

            -- first open the sidebar if it's not already open
            local avante_api = require('avante.api')
            avante_api.ask()

            -- get the sidebar after it's fully initialized
            local sidebar = require('avante').get()

            -- now the sidebar should have a file_selector
            if sidebar and sidebar.file_selector then
              sidebar.file_selector:add_selected_file(relative_path)

              -- remove neo-tree buffer from selection if it was automatically added
              if vim.bo.filetype == "neo-tree" then
                sidebar.file_selector:remove_selected_file('neo-tree filesystem [1]')
              end
            else
              -- if for some reason file_selector is still not available
              vim.notify("avante sidebar does not have file_selector available", vim.log.levels.ERROR)
            end
          end,
        },
        window = {
          mappings = {
            ['oa'] = 'avante_add_files',
          },
        },
      },
    })
  end,
}
