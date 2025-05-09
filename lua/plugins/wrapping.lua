return {
  -- `[ow` (soft wrap mode)
  -- `]ow` (hard wrap mode)
  -- `yow` (toggle wrap mode)
  "andrewferrier/wrapping.nvim",
  opts = {
    auto_set_mode_filetype_allowlist = {
      "asciidoc",
      "latex",
      "mail",
      "markdown",
      "rst",
      "tex",
    }
  },
  config = true
}

