-- ftplugins/markdown.lua
-- https://github.com/hrsh7th/nvim-cmp/issues/666
local cmp = require('cmp')
local sources = cmp.get_config().sources
for i = #sources, 1, -1 do
  -- i don't want buffer word completion in markdown files
  if sources[i].name == 'buffer' then
    table.remove(sources, i)
  end
end
cmp.setup.buffer({ sources = sources })

-- this is to address markdown "markup" being hidden
vim.opt_local.conceallevel= 0
