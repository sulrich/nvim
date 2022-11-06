-- misc. plugin configuration

-- all the pretty lights
-- vim.cmd("colorscheme solarized8")
vim.cmd([[colorscheme nord]])
vim.g.nord_contrast = true 
vim.g.nord_borders = true 
vim.g.nord_italic = false 
vim.g.nord_disable_background = true
require('nord').set()

-- lualine configuration
require('lualine').setup({
  options = {
    theme = 'nord',
    -- section_separators = '',
    -- component_separators = '',
  }
})

-- folding plugin setup 
-- ref: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
-- tell the sever the capability of foldingRange
vim.o.foldcolumn = "5"      -- 2 lines of column for fold showing, always
vim.o.foldlevel = 99        -- nvim.ufo needs a large value
vim.o.foldlevelstart = 99   -- 
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]


local ftMap = {
    vim = 'indent',
    python = {'treesitter', 'indent'},
    markdown = {'treesitter', 'indent'},
    git = ''
}
require('ufo').setup({
    open_fold_hl_timeout = 150,
    close_fold_kinds = {'imports', 'comment'},
    preview = {
        win_config = {
            border = {'', '─', '', '', '', '─', '', ''},
            winhighlight = 'Normal:Folded',
            winblend = 0
        },
        mappings = {
            scrollU = '<C-u>',
            scrollD = '<C-d>'
        }
    },
    provider_selector = function(bufnr, filetype, buftype)
        -- if you prefer treesitter provider rather than lsp,
        -- return ftMap[filetype] or {'treesitter', 'indent'}
        return ftMap[filetype]

        -- refer to ./doc/example.lua for detail
    end
})
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('n', 'K', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
        vim.lsp.buf.hover()
    end
end)


-- =================================================================
-- iron REPL config
local iron = require("iron.core")

iron.setup {
  config = {
    -- if iron should expose `<plug>(...)` mappings for the plugins
    should_map_plug = false,
    -- whether a repl should be discarded or not
    scratch_repl = true,
    -- your repl definitions come here
    repl_definition = {
      sh = {
        command = {"zsh"}
      }
    },
    repl_open_cmd = require('iron.view').bottom(20),
    -- how the REPL window will be opened, the default is opening
    -- a float window of height 40 at the bottom.
  },
  -- iron doesn't set keymaps by default anymore. set them here
  keymaps = {
    send_motion = "<space>sc",
    visual_send = "<space>sc",
    send_file = "<space>sf",
    send_line = "<space>sl",
    send_mark = "<space>sm",
    mark_motion = "<space>mc",
    mark_visual = "<space>mc",
    remove_mark = "<space>md",
    cr = "<space>s<cr>",
    interrupt = "<space>s<space>",
    exit = "<space>sq",
    clear = "<space>cl",
  },
  -- if the highlight is on, you can change how it looks
  -- for the available options, check nvim_set_hl
  highlight = {
    italic = false
  }
}
