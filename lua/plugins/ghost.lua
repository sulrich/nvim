local is_mac = vim.loop.os_uname().sysname == "Darwin"

return { 
  {
    'raghur/vim-ghost', 
    build = ":GhostInstall",
    lazy = false,
    -- this should only be enabled on macos
    enabled = is_mac,
    config = function()
      -- vim-ghost setup
      vim.cmd([[
      function! s:SetupGhostBuffer()
      if match(expand("%:a"), '\v/ghost-(gitlab|github|reddit).*-')
        set ft=markdown
        set spell
        endif
        endfunction

        augroup vim-ghost
        au!
        au User vim-ghost#connected call s:SetupGhostBuffer()
        augroup END
        ]])
      end,
      init = function()
        if vim.fn.has("gui_running") == 1 then
          -- only turn on ghost by default in a gui
          vim.g.ghost_autostart = 1
          vim.g.ghost_darwin_app = 'VimR'
        else
          vim.g.loaded_ghost = 0
        end
      end
    }
  } 
