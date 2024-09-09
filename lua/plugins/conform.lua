return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- customize or remove this keymap to your liking
      "<leader>f",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },

  -- this will provide type hinting with luals
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    -- define formatters
    formatters_by_ft = {
      python = function(bufnr)
        if require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "ruff_format" }
        else
          return { "isort", "black" }
        end
      end,
    },
    -- set default options
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 500 },
    -- customize formatters
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
  },

  init = function()
    -- if you want the formatexpr, here is the place to set it
    -- this seems to interfere with the operation of gw<motion> for markdown and
    -- other elements.
    --
    -- 20240909 (sulrich) 
    -- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    -- by default, format the buffer using black-ish formatting.  if i'm working
    -- on a project where they have their own formatting specification, i should
    -- stub a pyproject.toml file in place to suppress ruff operation, or
    -- disable this function and format using the project's tooling.
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.py",
      callback = function(args)
        require("conform").format({ bufnr = args.buf })
      end,
    })
  end,
}
