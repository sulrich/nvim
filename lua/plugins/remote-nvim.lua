-- plugin info: https://github.com/amitds1997/remote-nvim.nvim
local is_mac = vim.loop.os_uname().sysname == "Darwin"

return {
  "amitds1997/remote-nvim.nvim",
  version = "*", -- pin to github releases
  enabled = is_mac,
  dependencies = {
    "nvim-lua/plenary.nvim", 
    "MunifTanjim/nui.nvim", -- to build the plugin ui
    "nvim-telescope/telescope.nvim", -- for picking b/w different remote methods
  },
  config = true,
  opts = {
    remote = { 
      copy_dirs = {
        -- what to copy to remote's neovim config directory
        config = {
          dirs = { 
            "init.lua",
            "lua",
            "snippets",
            "spell",
            "ftplugin",
          },
        },
      },
    },
    -- launch a local neovide instance. this could use some attention.
    client_callback = function(port, _)
      local cmd = ("neovide --server localhost:%s"):format(port)
      vim.fn.jobstart(cmd, {
        detach = true,
      })
    end,
  },
}
