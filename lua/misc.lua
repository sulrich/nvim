-- misc. plugin configuration

-- all the pretty lights
-- vim.cmd("colorscheme solarized8")
vim.cmd([[colorscheme nord]])
vim.g.nord_italic = false 
-- vim.g.nord_disable_background = true
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
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
local language_servers = {} -- like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup({
        capabilities = capabilities,
        other_fields = ...
    })
end
require('ufo').setup()


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
