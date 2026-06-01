return {
  -- In-buffer markdown rendering (headings, code blocks, checkboxes, tables, callouts)
  -- Renders in normal mode, shows raw markdown in insert mode
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown" },
    opts = {
      win_options = {
        conceallevel = { rendered = 2, default = 0 },
      },
      heading = {
        sign = false,
        width = "block",
        right_pad = 2,
        backgrounds = { "RM_H1Bg", "RM_H2Bg", "RM_H3Bg", "RM_H4Bg", "RM_H5Bg", "RM_H6Bg" },
        foregrounds = { "RM_H1", "RM_H2", "RM_H3", "RM_H4", "RM_H5", "RM_H6" },
      },
      dash = { highlight = "RM_Dash" },
      code = { width = "block", right_pad = 1 },
    },
    config = function(_, opts)
      local function apply_hl()
        local hl = vim.api.nvim_set_hl
        hl(0, "RM_H1Bg", { bg = "#2d3b33" })
        hl(0, "RM_H1",   { fg = "#89b482", bold = true })
        hl(0, "RM_H2Bg", { bg = "#352e1a" })
        hl(0, "RM_H2",   { fg = "#d8a657", bold = true })
        hl(0, "RM_H3Bg", { bg = "NONE" })
        hl(0, "RM_H3",   { fg = "#e78a4e", bold = true })
        hl(0, "RM_H4Bg", { bg = "NONE" })
        hl(0, "RM_H4",   { fg = "#ea6962" })
        hl(0, "RM_H5Bg", { bg = "NONE" })
        hl(0, "RM_H5",   { fg = "#7daea3" })
        hl(0, "RM_H6Bg", { bg = "NONE" })
        hl(0, "RM_H6",   { fg = "#d3869b" })
        hl(0, "RM_Dash", { fg = "#504945" })
      end
      apply_hl()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("RenderMarkdownCustomHl", { clear = true }),
        callback = apply_hl,
      })
      require("render-markdown").setup(opts)
    end,
  },

  -- Browser-based live preview with synchronized scrolling
  -- Supports KaTeX math, Mermaid diagrams, PlantUML, etc.
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && npm install",
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown preview", ft = "markdown" },
    },
    init = function()
      vim.g.mkdp_auto_close = 0
    end,
  },
}
