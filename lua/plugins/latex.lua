-- LaTeX editing: vimtex (compilation, PDF, text objects) + texlab LSP
-- Requires: MacTeX (or BasicTeX), Skim.app
return {
  {
    "lervag/vimtex",
    ft = { "tex", "latex", "bib" },
    init = function()
      -- PDF viewer: Skim on macOS (supports SyncTeX forward/inverse search)
      vim.g.vimtex_view_method = "skim"
      -- Compiler: latexmk with continuous compilation
      vim.g.vimtex_compiler_method = "latexmk"
      -- Don't open quickfix on warnings, only on errors
      vim.g.vimtex_quickfix_mode = 0
      -- Disable vimtex's built-in completion (texlab LSP handles it)
      vim.g.vimtex_complete_enabled = 0
    end,
  },
}
