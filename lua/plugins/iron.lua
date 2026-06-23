return {
  -- see: https://github.com/Vigemus/iron.nvim
  "Vigemus/iron.nvim",
  cmd = {
    'IronRepl',
    'IronReplHere',
    'IronRestart',
    'IronSend',
    'IronFocus',
    'IronHide',
    'IronWatch',
    'IronAttach',
  },
  keys = {
    '<space>sc',
    '<space>sc',
    '<space>sf',
    '<space>sl',
    '<space>su',
    '<space>sm',
    '<space>mc',
    '<space>mc',
    '<space>md',
    '<space>s<cr>',
    '<space>s<space>',
    '<space>sq',
    '<space>cl',

    { '<space>rs', '<cmd>IronRepl<cr>' },
    { '<space>rr', '<cmd>IronRestart<cr>' },
    { '<space>rf', '<cmd>IronFocus<cr>' },
    { '<space>rh', '<cmd>IronHide<cr>' },
  },
  main = 'iron.core', -- informs lazy.nvim to use the entrypoint of `iron.core`
  opts = {
    config = {
      -- whether a repl should be discarded or not
      scratch_repl = true,
      -- repl definitions come here
      repl_definition = {
        sh = {
          -- can be a table or a function that
          -- returns a table (see below)
          command = { 'zhh' },
        },
        python = {
          command = { 
            "python3",
             { "ipython", "--no-autoindent" },
          },  
          -- format = common.bracketed_paste_python,
          block_dividers = { 
            "# %%", 
            "#%%" 
          },
          env = {
            PYTHON_BASIC_REPL = "1"
          } --needed for python3.13 and up.
        },
      },
      -- how the repl window will be displayed
      -- see below for more information
      -- repl_open_cmd = require('iron.view').bottom(40),
      repl_open_cmd = "split resize 20",
    },
    -- iron doesn't set keymaps by default anymore.
    -- set here or manually add keymaps to the functions in iron.core
    keymaps = {
      send_motion = '<space>sc',
      visual_send = '<space>sc',
      send_file = '<space>sf',
      send_line = '<space>sl',
      send_until_cursor = '<space>su',
      send_mark = '<space>sm',
      mark_motion = '<space>mc',
      mark_visual = '<space>mc',
      remove_mark = '<space>md',
      cr = '<space>s<cr>',
      interrupt = '<space>s<space>',
      exit = '<space>sq',
      clear = '<space>cl',
    },
    -- If the highlight is on, you can change how it looks
    -- For the available options, check nvim_set_hl
    highlight = { italic = false },
    ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
  },
}
