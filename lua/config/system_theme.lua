-- system_theme.lua automatically changes neovim background based on macos
-- system theme (dark/light)

local M = {}

-- function to check system theme and set background accordingly
function M.check_system_theme()
  -- only run in GUI mode (match the same check used in catppuccin.lua)
  local is_gui = vim.fn.has("gui_running") == 1
  if not is_gui and not vim.g.neovide and not vim.g.vimr then
    return
  end
  
  -- use defaults command to check if macos is in dark mode
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  if handle then
    local result = handle:read("*a")
    handle:close()
    
    -- schedule the background change to avoid fast event context issues
    vim.schedule(function()
      if result:match("Dark") then
        -- system is in dark mode
        vim.o.background = "dark"
      else
        -- system is in light mode (command returns nothing or error)
        vim.o.background = "light"
      end
    end)
  end
end

-- setup function to initialize the autocommand
function M.setup(opts)
  opts = opts or {}
  local check_interval = opts.check_interval or 3 * 60 * 1000 -- default: check every 3 minutes (in ms)
  
  -- only setup if in GUI mode (i.e. VimR)
  local is_gui = vim.fn.has("gui_running") == 1
  if not is_gui and not vim.g.neovide and not vim.g.vimr then
    return
  end
  
  -- check theme on startup
  M.check_system_theme()
  
  -- create autocommand group
  local augroup = vim.api.nvim_create_augroup("SystemThemeDetector", { clear = true })
  
  -- check on colorscheme change 
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = augroup,
    callback = function()
      -- after colorscheme changes, ensure background is still correct
      vim.defer_fn(M.check_system_theme, 10)
    end,
  })

  -- set up a timer to check periodically
  if not M.theme_check_timer then
    M.theme_check_timer = vim.uv.new_timer()
    M.theme_check_timer:start(check_interval, check_interval, function()
      M.check_system_theme()
    end)
  end
  
end

return M
