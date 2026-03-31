return {
  -- Code outline (treesitter-powered, replaces vista.vim)
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>o", "<cmd>AerialToggle!<cr>", desc = "Code outline" },
    },
    opts = {
      layout = { min_width = 30 },
    },
  },
}
