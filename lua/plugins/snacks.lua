return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    indent = { enabled = true },
    scratch= { enabled = true },
    gitbrowse = { enabled = true },
    toggle = { enabled = true, },
    -- gitbrowse = { enabled = true },
  },
  keys = {
	  { "<leader>.",  function() Snacks.scratch() end, desc = "toggle scratch buffer" },
	  { "<leader>S",  function() Snacks.scratch.select() end, desc = "select scratch buffer" },
    -- { "<leader>ug", function() Snacks.toggle.indent() end, },
    -- { "<leadern>nd", function() Snacks.toggle.indent() end, desc = "toggle snacks indentation" }, 
	  -- { "<leader>bd", function() Snacks.bufdelete() end, desc = "delete buffer" },
	  -- { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "rename file" },
	  { "<leader>gB", function() Snacks.gitbrowse() end, desc = "git browse" },
	  { "<leader>gb", function() Snacks.git.blame_line() end, desc = "git blame line" },
    { "<leader>io", function() Snacks.indent.enable() end, desc= "enable indent" },
    { "<leader>if", function() Snacks.indent.disable() end, desc= "disable indent" },
    { "<leader>ii", function() Snacks.toggle.indent() end, desc= "disable indent" },
	  -- { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "lazygit current file history" },
	  -- { "<leader>gg", function() Snacks.lazygit() end, desc = "lazygit" },
	  -- { "<leader>gl", function() Snacks.lazygit.log() end, desc = "lazygit log (cwd)" },
  },
}
