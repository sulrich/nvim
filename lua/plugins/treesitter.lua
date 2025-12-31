return {
  -- note: http://www.lazyvim.org/plugins/treesitter - has some interesting bits
  -- for configuration of treesitter under lazy.nvim.  check this if running
  -- into issues.
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "main",
  lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  opts = {
    indent = { 
      enable = true, -- by default enable
      disable = {
        "markdown",  -- somehow, it makes markdown worse
      },
    },
    -- a list of parser names, or "all" (the listed parsers must always be installed)
    ensure_installed = {
      "bash",
      "c",
      -- "css",              -- snacks.image
      "csv",
      "diff",
      "dockerfile",
      "go",
      "html",
      "javascript",
      "json",
      -- "jsonc",
      -- "latex",            -- snacks.image
      "lua",
      "markdown",
      "markdown_inline",
      -- "norg",             -- snacks.image
      "proto",
      "python",
      "query",
      "regex",
      "rust",
      -- "scss",             -- snacks.image
      "sql",
      -- "svelte",           -- snacks.image
      "toml",
      -- "tsx",              -- snacks.image
      -- "typst",            -- snacks.image
      "vim",
      "vimdoc",
      -- "vue",              -- snacks.image
      "yaml",
      "yang",
    },

    -- install parsers synchronously (only applied to `ensure_installed`)
    sync_install = true,

    -- automatically install missing parsers when entering buffer
    -- recommendation: set to false if you don't have `tree-sitter` cli installed locally
    auto_install = true,

    -- list of parsers to ignore installing (or "all")
    -- ignore_install = { },

    highlight = {
      enable = true,
      -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
      -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      -- the name of the parser)
      -- list of language that will be disabled
      -- disable = { "c", "rust" },
      --
      -- or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
      --
      -- disable = function(lang, buf)
      --   local max_filesize = 100 * 1024 -- 100 KB
      --   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      --   if ok and stats and stats.size > max_filesize then
      --     return true
      --   end
      -- end,

      -- setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- using this option may slow down your editor, and you may see some duplicate highlights.
      -- instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
  },
  config = function(_, opts)
    local TS = require("nvim-treesitter")

    -- some quick sanity checks
    if not TS.get_installed then
      vim.notify("please use `:Lazy` and update `nvim-treesitter`", vim.log.levels.ERROR)
      return
    elseif type(opts.ensure_installed) ~= "table" then
      error("`nvim-treesitter` opts.ensure_installed must be a table")
      return
    end

    -- setup treesitter
    TS.setup(opts)

    -- get currently installed parsers
    local installed = TS.get_installed()
    local installed_set = {}
    for _, lang in ipairs(installed) do
      installed_set[lang] = true
    end

    -- install missing parsers
    local to_install = {}
    for _, lang in ipairs(opts.ensure_installed or {}) do
      if not installed_set[lang] then
        table.insert(to_install, lang)
      end
    end

    if #to_install > 0 then
      vim.notify("installing missing treesitter parsers: " .. table.concat(to_install, ", "), vim.log.levels.INFO)
      
      -- install parsers using the lua API
      vim.schedule(function()
        TS.install(to_install)
      end)
    end
  end,
}
