return {
  -- Default theme (loaded eagerly)
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_better_performance = 1
      vim.o.background = "dark"
      vim.cmd.colorscheme("gruvbox-material")

      for _, hl in ipairs({ "Normal", "NormalNC", "SignColumn", "EndOfBuffer" }) do
        vim.api.nvim_set_hl(0, hl, { bg = "NONE" })
      end
    end,
  },

  -- Alternative themes (lazy-loaded, activated via <Space>tt picker)
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    config = function()
      require("rose-pine").setup({ dim_inactive_windows = true })
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
  },
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
