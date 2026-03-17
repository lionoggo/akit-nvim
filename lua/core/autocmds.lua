local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Restore cursor position on file open
autocmd("BufReadPost", {
  group = augroup("RestoreCursor", {}),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lines = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lines then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
      vim.cmd("normal! zvzz")
    end
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("TrimWhitespace", {}),
  pattern = "*",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

-- Auto reload file when changed externally
autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = augroup("AutoReload", {}),
  command = "checktime",
})

-- Hide line numbers in terminal
autocmd("TermOpen", {
  group = augroup("TerminalSettings", {}),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
  end,
})

-- Hide line numbers in quickfix
autocmd("FileType", {
  group = augroup("QuickfixSettings", {}),
  pattern = "qf",
  callback = function()
    vim.opt_local.number = false
  end,
})

-- Fix: neo-tree opens file without triggering filetype detection
autocmd("BufWinEnter", {
  group = augroup("EnsureFiletype", {}),
  callback = function(args)
    if vim.bo[args.buf].filetype == "" and vim.bo[args.buf].buftype == "" then
      local name = vim.api.nvim_buf_get_name(args.buf)
      if name ~= "" then
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(args.buf) and vim.bo[args.buf].filetype == "" then
            vim.cmd("filetype detect")
          end
        end)
      end
    end
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("HighlightYank", {}),
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Markdown: writing-friendly buffer settings
autocmd("FileType", {
  group = augroup("MarkdownSettings", {}),
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
    vim.opt_local.conceallevel = 2
  end,
})

-- LaTeX: writing-friendly buffer settings
autocmd("FileType", {
  group = augroup("LatexSettings", {}),
  pattern = { "tex", "latex" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end,
})
