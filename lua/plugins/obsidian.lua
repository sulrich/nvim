local is_mac = vim.loop.os_uname().sysname == "Darwin"

HOME = os.getenv("HOME")
return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    enabled = is_mac,
    lazy = true,
    -- ft = "markdown",
    -- replace the above line with this if you only want to load obsidian.nvim for
    -- markdown files in your vault:
    event = {
      -- if you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- e.g. "bufreadpre " .. vim.fn.expand "~" .. "/my-vault/*.md"
      -- refer to `:h file-pattern` for more examples
      "BufReadPre " .. HOME .. "/src/personal/obsidian/personal-journal/*.md",
      "BufNewFile " .. HOME .. "/src/personal/obsidian/personal-journal/*.md",
      -- "BufNewFile path/to/my-vault/*.md",
    },
    dependencies = {
      -- required.
      "nvim-lua/plenary.nvim",
    },
    opts = {
      picker = {
        name = "snacks.pick",
      },
      ui = {
        enable = false,
      },
      workspaces = {
        {
          name = "personal-journal",
          path = "~/src/personal/obsidian/personal-journal",
          overrides = {
            notes_subdir = "2025",
          },
        }, -- end workspaces definition
      },
      -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
      completion = {
        -- enables completion using nvim_cmp
        nvim_cmp = false,
        -- enables completion using blink.cmp
        blink = true,
        -- trigger completion at 2 chars.
        min_chars = 4,
      },
      new_notes_location = "notes_subdir",
    },
  }
}
