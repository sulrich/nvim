# overview

my personal collection of nvim shiz. this is all lua oriented in nature and is
only applicable to nvim.  all modules are managed and installed by `lazy.nvim`.
note, `lazy.nvim` the dependency tracker and installer, not the LazyNvim editor
distribution.

all of this should reside in `${HOME}/.config/nvim`.  

on first run, this will attempted to pull down all of the interesting elements
from github and install the necessary packages.

## using uv venv for neovim

this assumes the presence of a `uv` managed venv.  this should be setup as
follows. (from this directory)

```shell
uv venv  # this creates $CWD/.venv
source .venv/bin/activate
uv pip install neovim --upgrade
uv pip install pynvim --upgrade
uv pip install pyright --upgrade
uv pip install ruff --upgrade
```

as there is a need to add python modules, etc. for packages, this virtual env
should be populated with the relevant modules.

## github

note that a couple of these tokens rely on the availability of the following
environment variables to play nicely with github and the `gh` commands.

- GH_TOKEN
- GITHUB_TOKEN

these should be exported via `.envrc` files placed within the respective source
hierarchies to ensure that the tools have the right token access.  i like
something along the lines of the following to keep things in check here.

```bash
export GH_TOKEN={{ op ... path to credential }}
export GITHUB_TOKEN=${GH_TOKEN}
```

## 20260311 - codecompanion issue

```text
- This is a version compatibility issue, not a config error. codecompanion.nvim
  removed interactions.chat.variables in v19.0.0, but mcphub.nvim still expects it
  (was written for v18). The variables.lua crashes trying to iterate over a nil
  table.

  The short-term fix is to disable make_vars in your mcphub opts — that's the
  feature that calls the broken code path. The tools and slash commands will
  still work.

⏺ Update(lua/plugins/codecompanion.lua)
  ⎿  Added 1 line, removed 1 line
      101            callback = "mcphub.extensions.codecompanion",
      102            opts = {
      103              show_result_in_chat = true,  -- show mcp tool results in chat
      104 -            make_vars = true,            -- convert resources to #variables
      104 +            make_vars = false,           -- disabled: broken in codecompanion v19 (variables key removed)
      105              make_slash_commands = true,  -- add prompts as /slash commands
      106            }
      107          } -- end: mcphub extension

- This is a mcphub.nvim bug — it hasn't been updated for codecompanion v19. You
  could watch https://github.com/ravitemer/mcphub.nvim for a v19 compatibility
  fix. Once they release it, you can re-enable make_vars = true.
```
