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

-- Ensure filetype detection for buffers that bypass normal detection (e.g. snacks.explorer)
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
    vim.opt_local.conceallevel = 2
  end,
})

-- Linux: warn if no clipboard provider is installed
if vim.fn.has("linux") == 1 then
  autocmd("VimEnter", {
    group = augroup("ClipboardCheck", {}),
    once = true,
    callback = function()
      local has_clip = vim.fn.executable("xclip") == 1
        or vim.fn.executable("xsel") == 1
        or vim.fn.executable("wl-copy") == 1
      if not has_clip then
        vim.notify(
          "未检测到 xclip/xsel/wl-clipboard，系统剪贴板不可用\n"
            .. "X11: sudo apt install xclip\n"
            .. "Wayland: sudo apt install wl-clipboard",
          vim.log.levels.WARN
        )
      end
    end,
  })
end

-- Explorer: switch to English input method on enter
autocmd("BufEnter", {
  group = augroup("ExplorerIMSwitch", {}),
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "snacks_picker_list" then
      return
    end
    if vim.fn.has("mac") == 1 and vim.fn.executable("im-select") == 1 then
      vim.fn.jobstart({ "im-select", "com.apple.keylayout.ABC" })
    elseif vim.fn.executable("fcitx5-remote") == 1 then
      vim.fn.jobstart({ "fcitx5-remote", "-c" })
    elseif vim.fn.executable("ibus") == 1 then
      vim.fn.jobstart({ "ibus", "engine", "xkb:us::eng" })
    end
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
