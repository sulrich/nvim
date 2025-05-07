return {
  -- note: http://www.lazyvim.org/plugins/treesitter - has some interesting bits
  -- for configuration of treesitter under lazy.nvim.  check this if running
  -- into issues.
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  opts = {
    indent = { enable = true },
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
    require("nvim-treesitter.configs").setup(opts)
  end,
}
