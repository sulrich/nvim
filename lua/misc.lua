-- misc. plugin configuration

-- nvim-zk configuration 
-- require("zk").setup({
--   -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
--   -- it's recommended to use "telescope" or "fzf"
--   picker = "telescope",

--   lsp = {
--     -- `config` is passed to `vim.lsp.start_client(config)`
--     config = {
--       cmd = { "zk", "lsp" },
--       name = "zk",
--       -- on_attach = ...
--       -- etc, see `:h vim.lsp.start_client()`
--     },

--     -- automatically attach buffers in a zk notebook that match the given filetypes
--     auto_attach = {
--       enabled = true,
--       filetypes = { "markdown" },
--     },
--   },
-- })


-- folding plugin setup 
-- ref: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
-- tell the sever the capability of foldingRange
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
require('ufo').setup()

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
    repl_open_cmd = require('iron.view').curry.bottom(20),
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
