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
    opts = {},
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
