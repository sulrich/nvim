return {
  "pwntester/octo.nvim",
  cmd = "Octo",
  opts = {
    -- or "fzf-lua" or "snacks" or "default"
    picker = "snacks",
    -- bare Octo command opens picker of commands
    enable_builtin = true,
  },
  keys = {
    {
      "<leader>oi",
      "<CMD>Octo issue list<CR>",
      desc = "list github issues",
    },
    {
      "<leader>op",
      "<CMD>Octo pr list<CR>",
      desc = "list github pullrequests",
    },
    {
      "<leader>od",
      "<CMD>Octo discussion list<CR>",
      desc = "list github discussions",
    },
    {
      "<leader>on",
      "<CMD>Octo notification list<CR>",
      desc = "list github notifications",
    },
    {
      "<leader>os",
      function()
        require("octo.utils").create_base_search_command { include_current_repo = true }
      end,
      desc = "search github",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- "nvim-telescope/telescope.nvim",
    -- OR "ibhagwan/fzf-lua",
    "folke/snacks.nvim",
    "nvim-tree/nvim-web-devicons",
  },
}
