-- ftplugins/markdown.lua

-- this is to address markdown "markup" being hidden
vim.opt_local.conceallevel= 0

-- enable spell checking
vim.opt_local.spell = true

-- make sure that this is set explicitly
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

-- fix list indentation: disable vim's markdown indentexpr which hardcodes 4 spaces
-- this allows shiftwidth=2 to work correctly for list items
vim.opt_local.indentexpr = ""
vim.opt_local.autoindent = true
vim.opt_local.smartindent = false

-- configure list formatting
-- this pattern matches: -, *, +, and numbered lists (1., 2., etc.)
vim.opt_local.formatlistpat = [[^\s*\%(\d\+\.\|[-*+]\)\s\+]]
vim.opt_local.formatoptions:append("n")
