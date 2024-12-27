local is_mac = vim.uv.os_uname().sysname == "Darwin"

return {
  "Tsuzat/NeoSolarized.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  enabled = is_mac,  -- this is my mac workstation theme
  dependencies = { 'nvim-lualine/lualine.nvim' },
  config = function()
    local ok_status, NeoSolarized = pcall(require, "NeoSolarized")

    if not ok_status then
      return
    end
    -- settings for NeoSolarized
    NeoSolarized.setup {
      style = "dark", -- "dark" or "light"
      transparent = false, -- true/false; Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
      enable_italics = false, -- Italics for different hightlight groups (eg. Statement, Condition, Comment, Include, etc.)
      styles = {
        -- Style to be applied to different syntax groups
        comments = { italic = false },
        keywords = { italic = false },
        functions = { bold = true },
        variables = {},
        string = { italic = false },
        underline = true, -- true/false; for global underline
        undercurl = true, -- true/false; for global undercurl
      },
      -- add specific hightlight groups
      -- on_highlights = function(highlights, colors)
        --    highlights.Include.fg = colors.red -- Using `red` foreground for Includes
        -- end,
      }
      vim.cmd [[ colorscheme NeoSolarized ]]
    end
}
