return {
  {
    dir = "/Users/sulrich/src/personal/gist.nvim",
    cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
    config = true,
    opts = {
      -- private = false, -- All gists will be private, you won't be prompted again,
      -- personally, i like the prompt.
      -- note that the following 2 options are only available in my fork
      gh_cmd = "/usr/local/bin/op plugin run -- gh",
      split_direction = "horizontal", -- window split direction [vertical | horizontal]
      clipboard = "+", -- The registry to use for copying the Gist URL
      list = {
        -- If there are multiple files in a gist you can scroll them,
        -- with vim-like bindings n/p next previous
        mappings = {
          next_file = "<C-n>",
          prev_file = "<C-p>"
        }
      }
    }
  },
  -- `GistsList` opens the selected gist in a terminal buffer,
  -- nvim-unception uses neovim remote rpc functionality to open the gist in an actual buffer
  -- and prevents neovim buffer inception
  {
    "samjwill/nvim-unception",
    lazy = false,
    init = function()
      vim.g.unception_block_while_host_edits = true
    end
  }
}
