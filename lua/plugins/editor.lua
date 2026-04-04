return {
  -- Surround (replaces vim-surround)
  {
    "echasnovski/mini.surround",
    version = false,
    event = "VeryLazy",
    opts = {
      -- ys{motion}{char}  add surround
      -- ds{char}          delete surround
      -- cs{old}{new}      change surround
      mappings = {
        add = "sa",
        delete = "sd",
        replace = "sr",
        find = "sf",
        find_left = "sF",
        highlight = "sh",
        update_n_lines = "sn",
      },
    },
  },

  -- Comments (treesitter-aware, enhances native gc/gcc)
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Autopairs
  {
    "echasnovski/mini.pairs",
    version = false,
    event = "InsertEnter",
    opts = {},
  },

  -- Flash (jump anywhere with 2 keystrokes)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
    },
  },

  -- Which-key (keymap discovery)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>b", group = "Buffer" },
        { "<leader>s", group = "Spell" },
        { "<leader>t", group = "Translate" },
        { "<Space>g", group = "Git" },
        { "<Space>t", group = "Toggle" },
        { "<Space>d", group = "Diagnostics" },
        { "<Space>k", group = "Keymaps" },
        { "<leader>q", group = "Session/Quit" },
      },
    },
    keys = {
      { "<leader>?", function() require("which-key").show({ global = true }) end, desc = "All keymaps" },
    },
  },

  -- Undotree (keep your undo history visible)
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undo tree" },
    },
  },
}
