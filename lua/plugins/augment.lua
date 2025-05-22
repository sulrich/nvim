local is_mac = vim.loop.os_uname().sysname == "Darwin"
-- local is_right_host = vim.uv.os_gethostname() == "waffletron"

return {
  {
    'augmentcode/augment.vim',
    cmd = { "Augment", },
    -- cond = is_right_host,
    lazy = true,
    cond = is_mac,
    enabled = false,
    keys = {
      { "<leader>ac", ":Augment chat<CR>", mode = "n", noremap = true, silent = true },
      { "<leader>ac", ":Augment chat<CR>", mode = "v", noremap = true, silent = true },
      { "<leader>an", ":Augment chat-new<CR>", mode = "n", noremap = true, silent = true },
      { "<leader>at", ":Augment chat-toggle<CR>", mode = "n", noremap = true, silent = true },
    },
    -- enabling opts = { } seems to tickle bad behaviors in augment and lazy.

  }
}
