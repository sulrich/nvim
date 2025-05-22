local is_mac = vim.loop.os_uname().sysname == "Darwin"

return{
  {
    "Davidyz/VectorCode",
    enabled = is_mac,
    version = "*", -- optional, depending on whether you're on nightly or release
    build = "uv tool install vectorcode --upgrade", -- optional but recommended if you set `version = "*"`
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "VectorCode", -- if you're lazy-loading VectorCode
  },
}
