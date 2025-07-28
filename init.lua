HOME = os.getenv("HOME")
TMPDIR = os.getenv("TMPDIR")

-- disable netrw at the very start of your init.lua
-- this is in the service of nvim-tree.lua (see lua/plugings/net-tree.lua)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- leader should be set prior to invoking the lazy.vim bootstrap process
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require('config.lazy') -- get plugins loaded via lazy.nvim
require('keybindings') -- load non-plugin-specific keybindings
-- check system theme every 5 minutes
require('config.system_theme').setup({check_interval = 5 * 60 * 1000}) 

-- disable unused nvim providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- interface elements
vim.o.termguicolors = true -- enable 24-bit color
-- vim.g.background handled by system_theme.lua
vim.g.have_nerd_font = true

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
vim.o.cmdheight = 3   -- command line two lines high
vim.o.laststatus = 3  -- recommended for avante operation
vim.o.ruler = true    -- show line # info, etc.
vim.o.showmode = true -- show the mode in the status line
vim.o.showcmd = true  -- show selection info
vim.o.conceallevel = 2

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
-- vim.g.vmt_dont_insert_fence = 1
-- vim.g.vmt_list_item_char = "-"

-- vim python provider elements
vim.g.python3_host_prog = HOME .. "/.config/nvim/.venv/bin/python3"

-- spell check configuration
vim.o.spelllang = "en_us"
vim.o.spellcapcheck = ""       -- ignore capitalization
-- vim.opt.spellfile = HOME .. "/iCloud/src/configs/aspell/aspell.en.pws"`

-- diff settings
vim.o.diffopt = "filler,iwhite"     -- ignore all whitespace and sync

-- disable editorconfig for gitcommit buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.b.editorconfig = false
  end,
  desc = "disable editorconfig for gitcommit buffers"
})

-- autocommand group settings
vim.api.nvim_create_augroup("nvim_ghost_user_autocommands", { clear = true })

vim.api.nvim_create_autocmd("User", {
  pattern = "*stackoverflow.com",
  command = "setfiletype markdown | set spell",
  group = "nvim_ghost_user_autocommands",
})

vim.api.nvim_create_autocmd("User", {
  pattern = "*reddit.com",
  command = "setfiletype markdown | set spell",
  group = "nvim_ghost_user_autocommands",
})

vim.api.nvim_create_autocmd("User", {
  pattern = "*github.com",
  command = "setfiletype markdown | set spell",
  group = "nvim_ghost_user_autocommands",
})
