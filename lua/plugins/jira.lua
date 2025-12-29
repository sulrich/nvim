-- plugin info: https://github.com/letieu/jira.nvim
local is_mac = vim.loop.os_uname().sysname == "Darwin"
local is_right_host = vim.uv.os_gethostname() == "waffletron"

local function read_token()
  local token_file = vim.fn.expand("~/.credentials/jira.txt")
  local f = io.open(token_file, "r")
  if f then
    local token = f:read("*line")
    f:close()
    return token:gsub("^%s*(.-)%s*$", "%1") -- trim whitespace
  end
  return nil
end


return {
  {
    "letieu/jira.nvim",
    enabled = is_right_host,
    lazy = true,
    cmd = { "Jira" },
    opts = {
      jira = {
        base = "https://nexthopai.atlassian.net", -- base url of jira instance
        email = "sulrich@nexthop.ai",             -- jira email
        token = read_token(),                     -- jira api token
        limit = 500,                              -- global limit of tasks per view
      },
      projects = { },  -- populate this 
    },
  }
}
