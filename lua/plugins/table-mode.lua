-- 20260213 (sulrich): this is a classic vim-script plugin.  it has a few quirks
-- when mapped to lazy.nvim
-- https://github.com/dhruvasagar/vim-table-mode
return {
  {
    'dhruvasagar/vim-table-mode',
    lazy = true,
    cmd = { "TableModeToggle", "Tableize"},
    keys = {
      { '<leader>T', 'Tableize' },
    },
    -- note: in order to set global values, i need to use the init f(x)
    init = function()
      -- for vim-table-mode use markdown stule corners
      vim.g.table_mode_corner = '|'
    end,
  },
}
