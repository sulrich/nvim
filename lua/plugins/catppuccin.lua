local is_mac = vim.loop.os_uname().sysname == "Darwin"
local is_gui = vim.fn.has("gui_running") == 1

return { 
  {
    "catppuccin/nvim", 
    name = "catppuccin", 
    priority = 1000,
    lazy = false,
    -- this should only be enabled on macos (guis)
    cond = (is_mac and is_gui),
    dependencies = { 'nvim-lualine/lualine.nvim' },
    config = function()
      require("catppuccin").setup({
        flavour = "auto", -- latte, frappe, macchiato, mocha
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
