local map = vim.keymap.set
local vscode = require("vscode")

local function action(cmd)
  return function() vscode.action(cmd) end
end

-- =============================================
-- File operations
-- =============================================
map("n", "<leader>f", action("workbench.action.quickOpen"), { desc = "Find files" })
map("n", "<leader><leader>", action("workbench.action.findInFiles"), { desc = "Search in files" })

-- =============================================
-- Code navigation (g prefix)
-- =============================================
map("n", "gd", action("editor.action.revealDefinition"), { desc = "Go to definition" })
map("n", "gD", action("editor.action.revealDeclaration"), { desc = "Go to declaration" })
map("n", "gr", action("editor.action.goToReferences"), { desc = "References" })
map("n", "gi", action("editor.action.goToImplementation"), { desc = "Implementation" })
map("n", "K", action("editor.action.showHover"), { desc = "Hover doc" })

-- =============================================
-- Code actions (leader prefix)
-- =============================================
map("n", "<leader>rn", action("editor.action.rename"), { desc = "Rename" })
map("n", "<leader>ca", action("editor.action.quickFix"), { desc = "Code action" })
map("n", "<leader>fm", action("editor.action.formatDocument"), { desc = "Format" })
map("v", "<leader>fm", action("editor.action.formatSelection"), { desc = "Format selection" })

-- =============================================
-- Diagnostics
-- =============================================
map("n", "]d", action("editor.action.marker.next"), { desc = "Next diagnostic" })
map("n", "[d", action("editor.action.marker.prev"), { desc = "Prev diagnostic" })

-- =============================================
-- Editor / Buffer management
-- =============================================
map("n", "<Tab>", action("workbench.action.nextEditor"), { desc = "Next editor" })
map("n", "<S-Tab>", action("workbench.action.previousEditor"), { desc = "Prev editor" })
map("n", "<leader>q", action("workbench.action.closeActiveEditor"), { desc = "Close editor" })

-- =============================================
-- Window navigation
-- =============================================
map("n", "<C-h>", action("workbench.action.focusLeftGroup"), { desc = "Focus left group" })
map("n", "<C-l>", action("workbench.action.focusRightGroup"), { desc = "Focus right group" })
map("n", "<C-j>", action("workbench.action.focusBelowGroup"), { desc = "Focus below group" })
map("n", "<C-k>", action("workbench.action.focusAboveGroup"), { desc = "Focus above group" })

-- =============================================
-- UI toggles
-- =============================================
map("n", "<leader>e", action("workbench.action.toggleSidebarVisibility"), { desc = "Toggle sidebar" })
map("n", "<leader>nn", action("workbench.files.action.showActiveFileInExplorer"), { desc = "Reveal file in explorer" })

-- =============================================
-- Terminal & Git
-- =============================================
map("n", "<leader>'", action("workbench.action.terminal.toggleTerminal"), { desc = "Toggle terminal" })
map("n", "<leader>gg", action("workbench.action.terminal.new"), { desc = "New terminal (lazygit)" })

-- =============================================
-- Space as auxiliary leader
-- =============================================
map("n", "<Space>f", action("workbench.action.quickOpen"), { desc = "Find files" })
map("n", "<Space>s", action("workbench.action.findInFiles"), { desc = "Search in files" })
map("n", "<Space>b", action("workbench.action.showAllEditors"), { desc = "Show all editors" })
map("n", "<Space>r", action("workbench.action.openRecent"), { desc = "Recent files/projects" })
map("n", "<Space>h", action("workbench.action.showAllSymbols"), { desc = "Symbols" })
map("n", "<Space>d", action("workbench.actions.view.problems"), { desc = "Problems panel" })

-- Git
map("n", "<Space>gg", action("workbench.view.scm"), { desc = "Source control" })
map("n", "<Space>gb", action("gitlens.toggleFileBlame"), { desc = "Toggle git blame" })

-- Toggle
map("n", "<Space>tt", action("workbench.action.selectTheme"), { desc = "Switch theme" })
map("n", "<Space>tz", action("workbench.action.toggleZenMode"), { desc = "Zen mode" })
