# Swift Neovim Config

This is a small lazy.nvim configuration for terminal and tmux-first Swift development on macOS. It is intentionally built around SwiftPM, SourceKit-LSP, Telescope, completion, formatting, Git signs, and discoverable keymaps.

## Layout

- `init.lua` loads options, keymaps, and lazy.nvim.
- `lua/config/options.lua` contains editor defaults for fast terminal editing.
- `lua/config/keymaps.lua` contains global leader mappings and diagnostics.
- `lua/config/swiftpm.lua` contains the SwiftPM root and sibling-package discovery logic.
- `lua/config/lazy.lua` bootstraps and configures lazy.nvim.
- `lua/plugins/*.lua` contains one focused plugin spec per concern.

## Plugins

- `nvim-lspconfig`: configures `sourcekit-lsp` for SwiftPM projects.
- `nvim-treesitter`: provides Swift, Lua, and config-file syntax highlighting.
- `telescope.nvim`: primary navigation for files, grep, buffers, recent files, and Git files.
- `blink.cmp`: LSP-first completion with path and buffer fallback sources.
- `conform.nvim`: formats Swift through `swift-format`.
- `gitsigns.nvim`: lightweight Git hunk signs and hunk preview.
- `which-key.nvim`: shows available leader mappings without adding a UI framework.
- `kanagawa.nvim`: restores the previous `kanagawa-wave` colorscheme.

Telescope uses `plenary.nvim` as its required runtime dependency. Blink uses `blink.lib` as its required runtime dependency.

## SwiftPM Workspace Model

For a workspace like:

```text
root/BaseProject
root/Package1
root/Package2
```

Open Neovim from `root/BaseProject`, where `BaseProject/Package.swift` declares local dependencies such as `../Package1` and `../Package2`.

```sh
cd root/BaseProject
nvim .
```

The SourceKit-LSP root function prefers the current working directory when it contains `Package.swift`. That keeps files opened from sibling packages attached to the BaseProject SwiftPM graph, which is what SourceKit needs for cross-package definition, reference, rename, and diagnostic behavior.

Telescope file search and live grep also include sibling directories with their own `Package.swift`, so `../Package1` and `../Package2` are reachable without adding a file explorer plugin.

## Required Tools

Install the macOS toolchain and command-line utilities:

```sh
xcode-select --install
brew install swift-format ripgrep fd tree-sitter-cli
```

`sourcekit-lsp` is provided by the active Xcode or Swift toolchain and is launched through:

```sh
xcrun sourcekit-lsp
```

Check the active toolchain with:

```sh
xcrun --find sourcekit-lsp
swift --version
```

This config targets Neovim 0.12+ so it can use the current `nvim-lspconfig`, `nvim-treesitter`, and `blink.cmp` APIs.

Treesitter parsers are not installed automatically during startup. After installing `tree-sitter-cli`, run this once inside Neovim:

```vim
:TSInstall swift lua vim vimdoc markdown markdown_inline json yaml
```

## Core Keymaps

- `<leader>ff`: find files
- `<leader>fg`: live grep
- `<leader>fb`: buffers
- `<leader>fr`: recent files
- `<leader>gf`: Git files
- `gd`: go to definition
- `gr`: references
- `<leader>rn`: rename symbol
- `<leader>ca`: code action
- `[d` / `]d`: previous / next diagnostic
- `<leader>e`: line diagnostic
- `<leader>f`: format buffer

No file explorer, dashboard, terminal, AI assistant, or heavy UI plugin is included. Use tmux panes for servers, logs, tests, and external tools.
