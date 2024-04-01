HOME = os.getenv("HOME")
TMPDIR = os.getenv("TMPDIR")

-- bootstrap packer if we're not installed
 local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
 if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
   packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
 end

 -- disable netrw at the very start of your init.lua 
 -- this is in the service of nvim-tree.lua (see lua/misc.lua)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


vim.o.termguicolors = true -- enable 24-bit color
vim.g.background = "auto" 

require('plugins')
require('lsp-configs')
require('misc')
require('keybindings')

vim.o.encoding = "utf-8" -- self-explanatory
vim.o.textwidth = 80     -- where to wrap
vim.o.shortmess = "at"   -- abbreviate and truncate file messages
vim.o.showmatch = true   -- briefly flash to the matching element

vim.o.visualbell = true  -- disable the beep
vim.o.autoread = true    -- if a file changes externally, update buffer

-- address the tabs-vs-spaces debate ...
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true

-- interface configuration
vim.o.cmdheight = 2   -- command line two lines high
vim.o.laststatus = 2
vim.o.ruler = true    -- show line # info, etc.
vim.o.showmode = true -- show the mode in the status line
vim.o.showcmd = true  -- show selection info


vim.o.wildmode = "longest:full"
vim.o.wildignore = "*.o,*~,.lo" -- ignore object files
vim.o.wildmenu = true  -- menu has tab completion

-- make the copy/paste operation seamless w/the OS
vim.o.clipboard = "unnamed"

-- delay before swap is written to the disk (100ms)
vim.o.updatetime = 100
vim.o.ttimeout = true 
vim.o.ttimeoutlen = 100

-- split preferences
vim.o.splitbelow = true 
vim.o.splitright = true 

-- search settings
-- ---------------------------------------------------------------------------
vim.o.incsearch = true  -- incremental search
vim.o.ignorecase = true -- search ignoring case
vim.o.smartcase = true  -- search w/a capital is case-sensitive
vim.o.hlsearch = true   -- highlight the search

-- misc. vim support files and settings. swap, backup, etc.
vim.o.swapfile = true
vim.o.directory = HOME .. "/.config/nvim/swap//"
vim.o.writebackup = false                  -- set for coc integration
vim.o.backup = false                       -- but do not persist backup after successful write
vim.o.backupcopy = "auto"                  -- use rename-and-write-new method whenever safe
vim.o.backupdir = HOME .. "/.config/nvim/backup//"
-- vim.o.backupdir = TMPDIR .. "//"
vim.o.undofile = true                      -- persist the undo tree for each file
-- vim.o.undodir = TMPDIR .. "//"
vim.o.undodir = HOME .. "/.config/nvim/undo//"

-- mode specific settings below
-- ---------------------------------------------------------------------------

-- filetype: json 
-- disable quote concealing in json files
vim.g.vim_json_conceal=0

-- filetype: markdown 
vim.g.markdown_folding = 1
vim.g.markdown_enable_folding = 1
vim.g.markdown_fenced_languages = {'html', 'python', 'javascript', 'bash=sh', 'shell=sh'}

-- vim-markdown-toc elements
vim.g.vmt_dont_insert_fence = 1
vim.g.vmt_list_item_char = "-"

-- vim python provider elements
vim.g.python3_host_prog = HOME .. "/.pyenv/shims/python3"

-- plugin settings below
-- --------------------------------------------------------------------------
-- editorconfig
vim.g.EditorConfig_exclude_patterns = {'fugitive://.*', 'scp://.*'}

-- snippets
vim.g.UltiSnipsExpandTrigger='<tab>'
-- shortcut to go to next position
vim.g.UltiSnipsJumpForwardTrigger='<C-j>'
-- shortcut to go to previous position
vim.g.UltiSnipsJumpBackwardTrigger='<C-k>'
vim.g.UltiSnipsSnippetDirectories = {"UltiSnips", "custom-snippets"}

-- spell check configuration
vim.o.spelllang = "en_us"
vim.o.spellcapcheck = ""       -- ignore capitalization
-- personal word list
-- vim.opt.spellfile = HOME .. "/iCloud/src/configs/aspell/aspell.en.pws"
vim.cmd([[
" this seems to cause problems when moved to lua native config
" set spellfile = "~/iCloud/src/configs/aspell/aspell.en.pws"
]])


-- diff settings
vim.o.diffopt = "filler,iwhite"     -- ignore all whitespace and sync

-- for vim-table-mode use markdown stule corners
vim.g.table_mode_corner='|'
vim.g.fugitive_gitlab_domains = {'https://gitlab.aristanetworks.com'}

-- settings for neovide
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font Mono:h12"
  vim.g.neovide_cursor_vfx_mode = ""
  vim.g.neovide_cursor_animation_length = 0
  -- vim.g.neovide_transparency = 0
end

 
-- start: imported vimrc
vim.cmd([[
" plugin config/remappings below
" --------------------------------------------------------------------------
" editorconfig
autocmd FileType gitcommit let b:EditorConfig_disable = 1

" personal abbreviations
ab x70- ----------------------------------------------------------------------
ab x70= ======================================================================

" send stuff to pb - internal pb destination
command! -range=% Pb :<line1>,<line2>w !curl -F c=@- pb

" import any relevant API keys, etc. 
source ~/.credentials/vim-api-keys
]])
-- end: imported vimrc

-- vim-ghost setup
vim.cmd([[
function! s:SetupGhostBuffer()
if match(expand("%:a"), '\v/ghost-(partnerissue|gitlab|github|reddit).*-')
  set ft=markdown
  set spell
endif
endfunction

augroup vim-ghost
  au!
  au User vim-ghost#connected call s:SetupGhostBuffer()
augroup END
]])

if vim.fn.has("gui_running") == 1 then
  -- only turn on ghost by default in a gui
  vim.g.ghost_autostart = 1
  vim.g.ghost_darwin_app = 'VimR'
else
  vim.g.loaded_ghost = 0
end
