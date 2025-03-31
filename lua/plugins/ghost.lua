local is_mac = vim.loop.os_uname().sysname == "Darwin"
local is_gui = vim.fn.has("gui_running") == 1

return { 
  {
    'subnut/nvim-ghost.nvim',
    lazy = false,
    -- this should only be enabled on macos (guis)
    cond = (is_mac and is_gui),
    }
  } 
