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
