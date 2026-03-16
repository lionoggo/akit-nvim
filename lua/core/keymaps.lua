local map = vim.keymap.set

-- =============================================
-- Shared keymaps (works in VSCode + Neovim)
-- Leader: ,    Space: auxiliary leader
-- =============================================

-- Save
map("n", "<leader>w", "<cmd>w!<cr>", { desc = "Save file" })

-- Redo (U is easier than C-r)
map("n", "U", "<C-r>", { desc = "Redo" })

-- Screen line movement (swap j/k with gj/gk)
map("n", "j", "gj", { desc = "Down (screen line)" })
map("n", "k", "gk", { desc = "Up (screen line)" })
map("n", "gj", "j", { desc = "Down (real line)" })
map("n", "gk", "k", { desc = "Up (real line)" })

-- Yank to end of line (consistent with D, C)
map("n", "Y", "y$", { desc = "Yank to end of line" })

-- Select current line content (without newline)
map("n", "vv", "^vg_", { desc = "Select current line" })

-- Keep selection after indent
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Add semicolon at end of line
map("n", "<leader>;", "m'A;<ESC>`'", { desc = "Add ; at end of line" })

-- Command line movement
map("c", "<C-h>", "<Home>", { desc = "Start of line" })
map("c", "<C-l>", "<End>", { desc = "End of line" })

-- Clear search highlight
map("n", "<BS>", "<cmd>nohl<cr>", { desc = "Clear search highlight" })

-- Quit (use <leader>q instead of bare q, to preserve macro recording)
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

-- Quick open config
map("n", "<leader>rc", "<cmd>e ~/.config/nvim/init.lua<cr>", { desc = "Edit config" })

-- Visual mode search (search selected text with * or #)
map("v", "*", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], { desc = "Search selected forward" })
map("v", "#", [[y?\V<C-R>=escape(@",'/\')<CR><CR>]], { desc = "Search selected backward" })

-- Spell checking
map("n", "<leader>ss", "<cmd>setlocal spell!<cr>", { desc = "Toggle spell check" })
map("n", "<leader>sn", "]s", { desc = "Next misspelling" })
map("n", "<leader>sp", "[s", { desc = "Prev misspelling" })
map("n", "<leader>sa", "zg", { desc = "Add word to dict" })
map("n", "<leader>s?", "z=", { desc = "Suggest corrections" })

-- =============================================
-- Standalone Neovim only
-- =============================================
if not vim.g.vscode then
  -- Window navigation (Ctrl + direction)
  map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
  map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
  map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
  map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

  -- Terminal window navigation
  map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Go to left window" })
  map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Go to lower window" })
  map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Go to upper window" })
  map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Go to right window" })

  -- Window split (C-w + direction = split in that direction)
  -- Navigation is on <C-h/j/k/l>, so <C-w> prefix is free for splitting
  map("n", "<C-w>k", "<cmd>abo split<cr>", { desc = "Split above" })
  map("n", "<C-w>j", "<cmd>rightbelow split<cr>", { desc = "Split below" })
  map("n", "<C-w>h", "<cmd>abo vsplit<cr>", { desc = "Split left" })
  map("n", "<C-w>l", "<cmd>rightbelow vsplit<cr>", { desc = "Split right" })

  -- Window resize
  map("n", "<A-->", "<cmd>resize +3<cr>", { desc = "Increase height" })
  map("n", "<A-_>", "<cmd>resize -3<cr>", { desc = "Decrease height" })
  map("n", "<A-(>", "<cmd>vertical resize -3<cr>", { desc = "Decrease width" })
  map("n", "<A-)>", "<cmd>vertical resize +3<cr>", { desc = "Increase width" })
end
