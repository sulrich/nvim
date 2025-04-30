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
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = "NC", -- or "" to use 'winborder' on Neovim v0.11+
    enable_git_status = true,
    enable_diagnostics = true,
    open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
    source_selector = {
      winbar = true,
      statusline = false
    }
  },
}
