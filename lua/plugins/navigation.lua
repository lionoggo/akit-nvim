return {
  -- Fuzzy finder (fzf-lua, same speed as fzf but Lua-native)
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    keys = {
      -- Leader quick actions
      { "<leader>f", "<cmd>FzfLua files<cr>", desc = "Find files" },
      { "<leader><leader>", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },

      -- Space auxiliary leader
      { "<Space>f", "<cmd>FzfLua files<cr>", desc = "Find files" },
      { "<Space>s", "<cmd>FzfLua live_grep<cr>", desc = "Search text" },
      { "<Space>b", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
      { "<Space>r", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
      { "<Space>h", "<cmd>FzfLua help_tags<cr>", desc = "Help tags" },
      { "<Space>/", "<cmd>FzfLua grep_curbuf<cr>", desc = "Search in buffer" },
      { "<Space>d", "<cmd>FzfLua diagnostics_document<cr>", desc = "Diagnostics" },
      { "<Space>tt", "<cmd>FzfLua colorschemes<cr>", desc = "Switch theme" },
      { "<Space>gc", "<cmd>FzfLua git_commits<cr>", desc = "Git commits" },
      { "<Space>gs", "<cmd>FzfLua git_status<cr>", desc = "Git status" },
      { "<Space>km", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
    },
    opts = {
      winopts = {
        height = 0.85,
        width = 0.85,
        preview = { layout = "vertical", vertical = "down:45%" },
      },
    },
  },

  -- File tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file tree" },
      { "<leader>nn", "<cmd>Neotree reveal<cr>", desc = "Reveal in file tree" },
    },
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      window = {
        width = 35,
        mappings = {
          ["<space>"] = "none", -- don't conflict with Space leader
        },
      },
    },
  },

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
