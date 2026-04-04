return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      require("nvim-treesitter").setup()

      -- Attach treesitter to the initial buffer (BufReadPost already fired before lazy load)
      vim.schedule(function()
        local buf = vim.api.nvim_get_current_buf()
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= "" then
          vim.treesitter.start(buf)
        end
      end)

      -- Textobjects
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local ts_select = require("nvim-treesitter-textobjects.select")
      local ts_move = require("nvim-treesitter-textobjects.move")

      local select_maps = {
        ["af"] = { query = "@function.outer", desc = "outer function" },
        ["if"] = { query = "@function.inner", desc = "inner function" },
        ["ac"] = { query = "@class.outer", desc = "outer class" },
        ["ic"] = { query = "@class.inner", desc = "inner class" },
        ["aa"] = { query = "@parameter.outer", desc = "outer parameter" },
        ["ia"] = { query = "@parameter.inner", desc = "inner parameter" },
      }
      for key, mapping in pairs(select_maps) do
        vim.keymap.set({ "x", "o" }, key, function()
          ts_select.select_textobject(mapping.query)
        end, { desc = mapping.desc })
      end

      local move_next = {
        ["]f"] = { query = "@function.outer", desc = "Next function" },
        ["]c"] = { query = "@class.outer", desc = "Next class" },
      }
      for key, mapping in pairs(move_next) do
        vim.keymap.set({ "n", "x", "o" }, key, function()
          ts_move.goto_next_start(mapping.query)
        end, { desc = mapping.desc })
      end

      local move_prev = {
        ["[f"] = { query = "@function.outer", desc = "Prev function" },
        ["[c"] = { query = "@class.outer", desc = "Prev class" },
      }
      for key, mapping in pairs(move_prev) do
        vim.keymap.set({ "n", "x", "o" }, key, function()
          ts_move.goto_previous_start(mapping.query)
        end, { desc = mapping.desc })
      end
    end,
  },

  -- Show current code context at top of screen
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      max_lines = 3,
    },
  },
}
