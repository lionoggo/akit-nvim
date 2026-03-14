return {
  -- Default theme (loaded eagerly)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      integrations = {
        aerial = true,
        flash = true,
        gitsigns = true,
        indent_blankline = { enabled = true },
        mason = true,
        neo_tree = true,
        treesitter = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Alternative themes (lazy-loaded, activated via <Space>tt picker)
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "night" },
  },
  {
    "sainnhe/gruvbox-material",
    lazy = true,
    config = function()
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_better_performance = 1
    end,
  },
  {
    "tomasr/molokai",
    lazy = true,
  },
}
