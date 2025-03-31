-- i need to wrap these checks into something more comprehensive, but i think
-- this will do the trick immediately
local is_mac = vim.uv.os_uname().sysname == "Darwin"
local is_right_host = vim.uv.os_gethostname() == "neon" 
-- or vim.uv.os_gethostname() == "neon"

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  enabled = is_right_host,
  -- lazy = false,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    provider = "claude",
    -- add any opts here
    claude = {
      model = "claude-3-7-sonnet-20250219",
      max_tokens = 20480,
    },
    behaviour = {
      enable_cursor_planning_mode = true,
      enable_claude_text_editor_tool_mode = true,
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- the following dependencies are optional,
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "Avante" },
        latex = {
          enabled = false,
        },
        html = {
          enabled = false,
        },
      },
      ft = { "Avante" },
    },
  },
}
