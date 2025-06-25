local is_mac = vim.loop.os_uname().sysname == "Darwin"
return {
  {
    "olimorris/codecompanion.nvim",
    enabled = is_mac,
    init = function()
      vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
      vim.keymap.set({ "n", "v" }, "<LocalLeader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
      vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd([[cab cc CodeCompanion]])
    end,
    opts = {
      strategies = {
        -- chat adapter
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "anthropic",
          keymaps = {
            accept_change = {
              modes = { n = "ga" },
              description = "Accept the suggested change",
            },
            reject_change = {
              modes = { n = "gr" },
              description = "Reject the suggested change",
            },
          },
        },
        cmd = {
          adapter = "anthropic",
        },
      },
      -- set debug logging
      log_level = "DEBUG",
      extensions = {
        vectorcode = {
          opts = {
            add_tool = true,
            add_slash_command = true,
            tool_opts = {}
          },
        },
        history = {
          enabled = true,
          opts = {
            -- keymap to open history from chat buffer (default: gh)
            keymap = "gh",
            -- keymap to save the current chat manually (when auto_save is disabled)
            save_chat_keymap = "sc",
            -- save all chats by default (disable to save only manually using 'sc')
            auto_save = true,
            -- number of days after which chats are automatically deleted (0 to disable)
            expiration_days = 0,
            -- Picker interface ("telescope" or "snacks" or "fzf-lua" or "default")
            picker = "snacks",
            -- automatically generate titles for new chats
            auto_generate_title = true,
            title_generation_opts = {
              -- adapter for generating titles (defaults to current chat adapter)
              adapter = nil, -- "copilot"
              -- model for generating titles (defaults to current chat model)
              model = nil, -- "gpt-4o"
            },
            -- on exiting and entering neovim, loads the last chat on opening chat
            continue_last_chat = true,
            -- when chat is cleared with `gx` delete the chat from history
            delete_on_clearing_chat = false,
            -- directory path to save the chats
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
            -- enable detailed logging for history extension
            enable_logging = false,
          }
        }
      },
      display = {
        action_palette = {
          width = 95,
          height = 5,
          prompt = "Prompt ", -- Prompt used for interactive LLM calls
          provider = "snacks", -- Can be "default", "telescope", or "mini_pick" or snacks!
          opts = {
            show_default_actions = true, -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
          },
        },
        diff = {
          enabled = true,
          close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
          layout = "vertical", -- vertical|horizontal split for default provider
          opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
          provider = "mini_diff", -- default|mini_diff
        },
        -- chat settings
        chat = {
          -- change the default icons
          icons = {
            pinned_buffer = " ",
            watched_buffer = "👀 ",
          },
          -- alter the sizing of the debug window
          debug_window = {
            ---@return number|fun(): number
            width = vim.o.columns - 5,
            ---@return number|fun(): number
            height = vim.o.lines - 2,
          },
          -- options to customize the ui of the chat buffer
          window = {
            layout = "vertical", -- float|vertical|horizontal|buffer
            position = right, -- left|right|top|bottom (nil will default depending on vim.opt.plitright|vim.opt.splitbelow)
            border = "single",
            height = 0.5,
            width = 0.45,
            relative = "editor",
            full_height = false, -- when set to false, vsplit will be used to open the chat buffer vs. botright/topleft vsplit
            opts = {
              breakindent = true,
              cursorcolumn = false,
              cursorline = false,
              foldcolumn = "0",
              linebreak = true,
              list = false,
              numberwidth = 1,
              signcolumn = "no",
              wrap = true,
            },
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
      {
        'echasnovski/mini.diff',
        version = false
      },
    },
  },
}
