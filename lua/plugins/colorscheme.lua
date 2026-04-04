return {
  -- Default theme (loaded eagerly)
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup()
      vim.cmd.colorscheme("cyberdream")
    end,
  },

  -- Alternative themes (lazy-loaded, activated via <Space>tt picker)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      flavour = "mocha",
      integrations = {
        aerial = true,
        flash = true,
        gitsigns = true,
        snacks_indent = true,
        mason = true,
        snacks = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
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
  {
    "patstockwell/vim-monokai-tasty",
    lazy = true,
    config = function()
      vim.g.vim_monokai_tasty_vivid = 1
    end,
  },
}
