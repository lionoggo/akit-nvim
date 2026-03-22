return {
  {
    "uga-rosa/translate.nvim",
    keys = {
      { "<leader>ts", "<cmd>Translate zh-CN<cr>", mode = { "n", "v" }, desc = "Translate to Chinese" },
      { "<leader>tr", "<cmd>Translate zh-CN -output=replace<cr>", mode = { "n", "v" }, desc = "Translate & replace" },
    },
    opts = {
      default = {
        command = "google",
      },
    },
  },
}
