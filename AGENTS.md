# AGENTS.md

## What this is

Personal Neovim config using **lazy.nvim** (the package manager, **not** LazyVim distro). Lives at `~/.config/nvim`.

## Architecture

```
init.lua               -- entrypoint: sets options, loads lazy, keybindings, system theme
lua/config/lazy.lua    -- lazy.nvim bootstrap + imports spec from lua/plugins/
lua/config/system_theme.lua -- macOS dark/light detection (GUI-only)
lua/keybindings.lua    -- global keymaps + LSP on_attach function (returned as table)
lua/plugins/*.lua      -- one file per plugin; each returns a lazy.nvim spec table
ftplugin/              -- filetype-specific settings (mix of lua and legacy vimscript)
snippets/              -- custom snippets in JSON format
```

Plugin specs are loaded via `{ import = "plugins" }` in `lua/config/lazy.lua:29`. Each file in `lua/plugins/` returns a lazy spec table. Some files bundle multiple plugins (e.g. `classic-vim.lua`, `obsidian.lua`, `codecompanion.lua`).

## Python venv (required)

This config uses a `uv`-managed venv at `.venv` inside the nvim config dir.

```shell
uv venv
source .venv/bin/activate
uv pip install neovim --upgrade
uv pip install pynvim --upgrade
uv pip install pyright --upgrade
uv pip install ruff --upgrade
```

The venv path is hardcoded at `init.lua:103`: `vim.g.python3_host_prog = HOME .. "/.config/nvim/.venv/bin/python3"`.

Additional python deps are listed in `pyproject.toml`.

## LSP

- Uses the new `vim.lsp.enable()` API, **not** `lspconfig[server].setup()` (see `lua/plugins/lsp.lua:74`).
- Completion is **blink.cmp**, not nvim-cmp.
- LSP `on_attach` keymaps are in `lua/keybindings.lua:63-85` (returned as `on_attach`).
- Python: `ruff` is the primary LSP. `basedpyright` is commented out.
- Markdown: `marksman`.
- `thriftls` for thrift files.
- `gopls` for Go.

## Formatting & linting

- Python: **conform.nvim** auto-formats on `BufWritePre` using `ruff_fix` + `ruff_format` (`lua/plugins/conform.lua:52-58`).
- Go: `go.nvim` runs `goimports` on `BufWritePre` (`lua/plugins/go.lua:13-22`).
- Linting: **nvim-lint** configured for markdown (`markdownlint`), proto (`protolint`), yaml (`yamllint`). No lua linter/formatter is configured for the config itself.

## Key gotchas

### codecompanion + mcphub compatibility

`make_vars = false` is **required** in `lua/plugins/codecompanion.lua:126`. codecompanion v19 removed `interactions.chat.variables`, so mcphub crashes if `make_vars` is enabled. Do not re-enable until mcphub fixes upstream compatibility.

### platform gating

Several plugins are disabled on non-macOS via `enabled = is_mac`:
- `codecompanion.nvim` (`lua/plugins/codecompanion.lua:6`)
- `obsidian.nvim` (`lua/plugins/obsidian.lua:10`)

System theme detection (`lua/config/system_theme.lua`) uses `defaults read -g AppleInterfaceStyle` and is macOS-only.

### lazy-lock.json

`.gitignore` excludes `lazy-lock.json`. It exists locally but is not version-controlled.

### netrw disabled

`init.lua:6-7` disables netrw (`vim.g.loaded_netrw = 1`, `vim.g.loaded_netrwPlugin = 1`). This is for nvim-tree compatibility.

### GH token env vars

Some plugins need `GH_TOKEN` and `GITHUB_TOKEN` environment variables. These are expected to be set via `.envrc` or similar (see `README.md:32-45`).

### EditorConfig

`vim.g.editorconfig = true` is set globally (`init.lua:115`) but explicitly **disabled** for `gitcommit` buffers (`init.lua:118-124`).

### Markdown settings

- Treesitter indent is **disabled** for markdown (`lua/plugins/treesitter.lua:14`).
- `conceallevel=0` enforced for markdown (`ftplugin/markdown.lua:4`).
- Hardcoded `indentexpr=""` to fix list indentation at shiftwidth=2 (`ftplugin/markdown.lua:19-21`).
- Spell check enabled for markdown files (`ftplugin/markdown.lua:7`).

### Tab/indent conventions

- Default: 2-space indentation, expandtab (`init.lua:39-42`).
- Python: 4-space indentation, shiftround, textwidth=79 (`ftplugin/python.vim`).
- Shell, YAML: 2-space, shiftround, textwidth=79 (`ftplugin/sh.lua`, `ftplugin/yaml.lua`).

### Disabled providers

`init.lua:22-24` disables perl, ruby, and node providers (`vim.g.loaded_perl_provider = 0`, etc.).
