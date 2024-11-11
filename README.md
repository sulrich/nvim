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
uv pip install neovim pynvim
uv pip install ruff 
uv pip install SimpleWebSocketServer slugify
```

as there is a need to add python modules, etc. for packages, this virtual env
should be populated with the relevant modules.
