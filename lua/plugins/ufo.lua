return {
  {
    'kevinhwang91/nvim-ufo',
    lazy = true,
    event = 'BufReadPost', -- load when a buffer is read
    dependencies = { 'kevinhwang91/promise-async' },
    -- folding plugin setup
    init = function()
      -- ref: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
      -- tell the sever the capability of foldingRange
      vim.o.foldcolumn = "5"    -- 2 lines of column for fold showing, always
      vim.o.foldlevel = 99      -- nvim.ufo needs a large value
      vim.o.foldlevelstart = 99 --
      vim.o.foldenable = true
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
      vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
      vim.keymap.set('n', 'K', function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end)
    end,
    config = function()
      local ftMap = {
        vim = { 'indent' },
        python = { 'lsp', 'indent' },
        markdown = { 'indent' },
        lua = { 'lsp', 'indent' },
        git = {},
      }
      require('ufo').setup({
        open_fold_hl_timeout = 150,
        close_fold_kinds_for_ft = { 'imports', 'comment' },
        preview = {
          win_config = {
            border = { '', '─', '', '', '', '─', '', '' },
            winhighlight = 'Normal:Folded',
            winblend = 0
          },
          mappings = {
            scrollU = '<C-u>',
            scrollD = '<C-d>'
          }
        },
        provider_selector = function(bufnr, filetype, buftype)
          -- if you prefer treesitter provider rather than lsp,
          -- return ftMap[filetype] or {'treesitter', 'indent'}
          return ftMap[filetype] or { 'indent' }
          -- refer to ./doc/example.lua for detail
        end
      })
    end
  }
}
