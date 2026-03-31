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
        close_command = function(n) Snacks.bufdelete(n) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        offsets = {
          { filetype = "snacks_explorer", text = "Explorer", highlight = "Directory" },
        },
      },
    },
    keys = {
      { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    },
  },

  -- Icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Snacks (dashboard + explorer + lazygit terminal)
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = { enabled = true },
      bufdelete = { enabled = true },
      explorer = { enabled = true, replace_netrw = true },
      indent = { enabled = true },
      scroll = { enabled = true },
      picker = {
        sources = {
          explorer = {
            tree = true,
            follow_file = true,
            hidden = true,
            git_status = true,
            diagnostics = true,
          },
        },
      },
    },
    keys = {
      { "<leader>e", function() Snacks.explorer() end, desc = "Toggle explorer" },
      { "<leader>nn", function() Snacks.explorer.reveal() end, desc = "Reveal in explorer" },
      { "<leader>gg", function() Snacks.terminal("lazygit") end, desc = "Lazygit" },
      { "<leader>'", function() Snacks.terminal() end, desc = "Terminal" },

      -- Picker (migrated from fzf-lua)
      { "<leader>f", function() Snacks.picker.files() end, desc = "Find files" },
      { "<leader><leader>", function() Snacks.picker.grep() end, desc = "Live grep" },
      { "<Space>f", function() Snacks.picker.files() end, desc = "Find files" },
      { "<Space>s", function() Snacks.picker.grep() end, desc = "Search text" },
      { "<Space>b", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<Space>r", function() Snacks.picker.recent() end, desc = "Recent files" },
      { "<Space>h", function() Snacks.picker.help() end, desc = "Help tags" },
      { "<Space>/", function() Snacks.picker.lines() end, desc = "Search in buffer" },
      { "<Space>d", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<Space>tt", function() Snacks.picker.colorschemes() end, desc = "Switch theme" },
      { "<Space>gc", function() Snacks.picker.git_log() end, desc = "Git commits" },
      { "<Space>gs", function() Snacks.picker.git_status() end, desc = "Git status" },
      { "<Space>km", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    },
  },
}
