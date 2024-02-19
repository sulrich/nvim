-- misc. plugin configuration

-- all the pretty lights
-- vim.cmd([[colorscheme nord]])
-- vim.g.nord_contrast = true 
-- vim.g.nord_borders = true 
-- vim.g.nord_italic = false 
-- vim.g.nord_disable_background = false
-- vim.g.nord_bold = false
-- require('nord').set()


local ok_status, NeoSolarized = pcall(require, "NeoSolarized")
if not ok_status then
  return
end

-- settings for NeoSolarized
NeoSolarized.setup {
  style = "dark", -- "dark" or "light"
  transparent = true, -- true/false; Enable this to disable setting the background color
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

-- lualine configuration
require('lualine').setup({
  options = {
    -- theme = 'nord',
    theme = 'NeoSolarized',
    -- section_separators = '',
    -- component_separators = '',
  }
})
--
-- set colorscheme to NeoSolarized - needs to be done _after_ configuration
vim.cmd [[ colorscheme NeoSolarized ]]

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

-- https://github.com/Rawnly/gist.nvim - suggested config. 
require("gist").setup({
  -- private = false, -- All gists will be private, you won't be prompted again,
  -- personally, i like the prompt.
  clipboard = "+", -- The registry to use for copying the Gist URL
  list = {
    -- If there are multiple files in a gist you can scroll them,
    -- with vim-like bindings n/p next previous
    mappings = {
      next_file = "<C-n>",
      prev_file = "<C-p>"
    }
  }
})


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
