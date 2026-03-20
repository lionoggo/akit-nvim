-- LaTeX editing: vimtex (compilation, PDF, text objects) + texlab LSP
-- Requires: MacTeX/BasicTeX + Skim.app (macOS) or TeX Live + zathura (Linux)

local function get_view_method()
  if vim.fn.has("mac") == 1 then
    return "skim"
  end
  if vim.fn.executable("zathura") == 1 then
    return "zathura"
  end
  return "general"
end

return {
  {
    "lervag/vimtex",
    ft = { "tex", "latex", "bib" },
    init = function()
      vim.g.vimtex_view_method = get_view_method()
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_complete_enabled = 0

      if vim.fn.has("linux") == 1 and vim.g.vimtex_view_method == "general" then
        vim.g.vimtex_view_general_viewer = "xdg-open"
      end
    end,
  },
}
