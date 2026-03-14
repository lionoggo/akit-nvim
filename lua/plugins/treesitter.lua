return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    main = "nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua", "python", "javascript", "typescript", "go", "rust",
        "java", "c", "cpp", "html", "css", "json", "yaml", "toml",
        "markdown", "markdown_inline", "bash", "vim", "vimdoc",
        "dockerfile", "sql",
      },
      highlight = {
        enable = true,
        -- Disable for LaTeX: vimtex's syntax highlighting is more accurate
        disable = { "latex" },
      },
      indent = { enable = true },
    },
  },

  -- Treesitter text objects: select/move by function, class, parameter
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost", "BufNewFile" },
    main = "nvim-treesitter-textobjects",
    opts = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = { query = "@function.outer", desc = "outer function" },
          ["if"] = { query = "@function.inner", desc = "inner function" },
          ["ac"] = { query = "@class.outer", desc = "outer class" },
          ["ic"] = { query = "@class.inner", desc = "inner class" },
          ["aa"] = { query = "@parameter.outer", desc = "outer parameter" },
          ["ia"] = { query = "@parameter.inner", desc = "inner parameter" },
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]f"] = { query = "@function.outer", desc = "Next function" },
          ["]c"] = { query = "@class.outer", desc = "Next class" },
        },
        goto_prev_start = {
          ["[f"] = { query = "@function.outer", desc = "Prev function" },
          ["[c"] = { query = "@class.outer", desc = "Prev class" },
        },
      },
    },
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
