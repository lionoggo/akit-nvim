return {
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Bufferline (buffer tabs at top)
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        close_command = "bdelete! %d",
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        offsets = {
          { filetype = "neo-tree", text = "Explorer", highlight = "Directory" },
        },
      },
    },
    keys = {
      { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete buffer" },
    },
  },

  -- Icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Snacks (dashboard + lazygit terminal)
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = { enabled = true },
    },
    keys = {
      { "<leader>gg", function() Snacks.terminal("lazygit") end, desc = "Lazygit" },
      { "<leader>'", function() Snacks.terminal() end, desc = "Terminal" },
    },
  },
}
