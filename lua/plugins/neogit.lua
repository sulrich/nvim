-- https://github.com/NeogitOrg/neogit
return {
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "sindrets/diffview.nvim",  -- diff integration
      "m00qek/baleia.nvim",      -- optional
      "folke/snacks.nvim",       -- picker 
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
    }
  }
}

