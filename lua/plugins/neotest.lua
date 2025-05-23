return {
  {
    -- https://github.com/nvim-neotest/neotest
    "nvim-neotest/neotest",
    enabled = true,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
      "fredrikaverpil/neotest-golang",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          -- https://github.com/nvim-neotest/neotest-python
          require("neotest-python"),
          -- https://fredrikaverpil.github.io/neotest-golang/
          require("neotest-golang")
        },
      })
    end,
    -- note the following came from https://www.lazyvim.org/extras/test/core
    -- TODO(sulrich): it would be nice to have the trbouel/quickfix integration
    -- that they show here in the LazyVim spec - it's the trouble integration
    -- that's particularly appealing 
    keys = {
      {"<leader>t", "", desc = "+test"},
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "run file (neotest)" },
      { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "run all test files (neotest)" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "run nearest (neotest)" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "run last (neotest)" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "toggle summary (neotest)" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "show output (neotest)" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "toggle output panel (neotest)" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "stop (neotest)" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "toggle watch (neotest)" },
    },
  },
  -- neotest plugins / runners
  { "nvim-neotest/neotest-python", enabled = true, },
  { "fredrikaverpil/neotest-golang",enabled = true, },
}
