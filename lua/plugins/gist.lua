-- HOME = os.getenv("HOME")
return {
  {
    "Rawnly/gist.nvim",
    -- vestigial from my development
    -- dir = HOME .. "/src/personal/gist.nvim",
    -- dev = true,
    -- 'sulrich/gist.nvim',
    -- branch = 'set-split-direction',
    cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
    config = true,
    opts = {
      platform = "github",
      clipboard = "+", -- the registry to use for copying the gist url
      prompts = {
        create = {
          private = true,
          description = true,
          confirmation = true,
        },
      },
      list = {
        -- if tmux is detected do something cool
        use_multiplexer = true,
        -- If there are multiple files in a gist you can scroll them,
        -- with vim-like bindings n/p next previous
        mappings = {
          next_file = "<C-n>",
          prev_file = "<C-p>"
        }
      }
    },
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
