-- Leader keys (must be set before lazy.nvim)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Core settings (shared across all environments)
require("core.options")
require("core.keymaps")

if vim.g.vscode then
  -- VSCode-Neovim: only keymaps, no plugins
  require("vscode.keymaps")
else
  -- Standalone Neovim: full setup
  require("core.autocmds")
  require("config.lazy")
end
