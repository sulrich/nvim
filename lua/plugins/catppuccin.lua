local is_mac = vim.loop.os_uname().sysname == "Darwin"
local is_gui = vim.fn.has("gui_running") == 1

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    -- this should only be enabled on macos (guis)
    -- 20260327(sulrich): using this pretty much everywhere
    enabled = true,
    -- enabled = is_mac,
    -- cond = (is_mac and is_gui), -- this is my mac gui theme
    -- cond = is_mac,
    dependencies = { 'nvim-lualine/lualine.nvim' },
    config = function()
      require("catppuccin").setup({
        -- this seems superfluous in my environment
        -- flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        no_italic = true,
        no_bold = true, -- force no bold
        no_underline = true, -- force no underline
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
        },
      })
      vim.cmd("colorscheme catppuccin")
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      theme = 'catppuccin',
    }
  }
}
