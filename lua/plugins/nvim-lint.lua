return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile", },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      markdown = { 'markdownlint', },
      python = { 'ruff' },
      proto = { 'protolint'},
      yaml = { 'yamllint'},
      -- yaml.ansible = { 'ansible_lint' },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "trigger linting for the current file" })
  end,
}
