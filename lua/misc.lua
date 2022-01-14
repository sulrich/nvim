-- misc. plugin configuration

-- iron REPL config
local iron = require('iron')
iron.core.set_config {
  preferred = {
    python = "ipython",
  },
  repl_open_cmd = 'bo 20 split'
}

