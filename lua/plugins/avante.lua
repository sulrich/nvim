-- i need to wrap these checks into something more comprehensive, but i think
-- this will do the trick immediately
local is_mac = vim.uv.os_uname().sysname == "Darwin"
local is_right_host = vim.uv.os_gethostname() == "waffletron" or vim.uv.os_gethostname() == "neon"

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
      -- reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      -- the following should only be enabled when i'm using claude
      behaviour = {
        enable_cursor_planning_mode = true,
        enable_claude_text_editor_tool_mode = true,
      },
    },
    gemini = {
      model = "gemini-2.5-pro-exp-03-25",
      max_tokens = 20480,
      -- reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
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
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-tree/nvim-web-devicons",
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
