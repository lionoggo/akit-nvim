return {
  -- Mason (LSP server installer)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      -- Diagnostic display
      vim.diagnostic.config({
        virtual_text = { spacing = 4, prefix = "●" },
        signs = true,
        underline = true,
        update_in_insert = false,
      })

      -- LSP keymaps (set on attach)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
          end

          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
          map("n", "gr", vim.lsp.buf.references, "References")
          map("n", "gi", vim.lsp.buf.implementation, "Implementation")
          map("n", "K", vim.lsp.buf.hover, "Hover doc")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
          map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
          map("n", "<Space>d", vim.diagnostic.open_float, "Line diagnostics")
        end,
      })

      -- Server setup via mason-lspconfig
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "ts_ls",
          -- "gopls",         -- uncomment when Go >= 1.22 is installed
          "rust_analyzer",
          "marksman",    -- Markdown: symbols, links, TOC
          "texlab",      -- LaTeX: completion, diagnostics, build
        },
        handlers = {
          -- Default handler for all servers
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,
          -- Lua: suppress "undefined global vim" warning
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  workspace = { checkThirdParty = false },
                  telemetry = { enable = false },
                },
              },
            })
          end,
          -- LaTeX: texlab with Skim forward search
          ["texlab"] = function()
            require("lspconfig").texlab.setup({
              capabilities = capabilities,
              settings = {
                texlab = {
                  build = {
                    executable = "latexmk",
                    args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                    onSave = true,
                  },
                  forwardSearch = {
                    executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
                    args = { "%l", "%p", "%f" },
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },

  -- Completion engine
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    event = "InsertEnter",
    opts = {
      keymap = { preset = "default" },
      appearance = {
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      signature = { enabled = true },
    },
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>fm",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        desc = "Format",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        -- go = { "gofmt" },
        rust = { "rustfmt" },
        json = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
}
