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
      image = { enabled = true },
      indent = { enabled = true },
      scroll = { enabled = true },
      picker = {
        sources = {
          files = { hidden = true, ignored = false },
          grep = { hidden = true, ignored = false },
          explorer = {
            tree = true,
            follow_file = true,
            hidden = true,
            ignored = true,
            git_status = true,
            diagnostics = true,
            -- 延迟显示（毫秒），光标停留超过此时间才弹出浮窗，0 表示立即显示
            _float_show_ms = 500,
            -- 自动隐藏延迟（毫秒），0 表示不自动隐藏
            _float_hide_ms = 3000,
            on_show = function(picker)
              -- 离开 Explorer 窗口时取消待显示计时器并立即关闭浮窗
              picker.list.win:on("WinLeave", function()
                local state = picker._filename_float
                if not state then return end
                local function cancel(t)
                  if t then pcall(function() t:stop() t:close() end) end
                end
                cancel(state.show_timer) state.show_timer = nil
                cancel(state.timer)      state.timer = nil
                if state.win and vim.api.nvim_win_is_valid(state.win) then
                  vim.api.nvim_win_close(state.win, true) state.win = nil
                end
              end, { buf = true })
            end,
            on_change = function(picker, item)
              local uv = vim.uv or vim.loop
              local state = picker._filename_float or {}
              picker._filename_float = state

              -- 焦点不在 explorer 时不显示浮窗（follow_file 会在编辑器中触发 on_change）
              if vim.api.nvim_get_current_win() ~= picker.list.win.win then
                return
              end

              local function cancel(t)
                if t then pcall(function() t:stop() t:close() end) end
              end

              -- 取消待显示计时器、关闭旧浮窗和隐藏计时器
              cancel(state.show_timer) state.show_timer = nil
              cancel(state.timer)      state.timer = nil
              if state.win and vim.api.nvim_win_is_valid(state.win) then
                vim.api.nvim_win_close(state.win, true) state.win = nil
              end

              if not item or not item.file then return end

              local name = vim.fn.fnamemodify(item.file, ":t")
              local list_win = picker.list.win.win
              local win_width = vim.api.nvim_win_get_width(list_win)

              -- 计算实际树形缩进深度：每层 2 字符，加上 icon 2 字符
              local depth = 0
              local node = item
              while node and node.parent do
                depth = depth + 1
                node = node.parent
              end
              local overhead = 2 * depth + 2

              -- 只在文件名超出可见宽度时启动计时器
              if vim.api.nvim_strwidth(name) <= win_width - overhead then return end

              -- 延迟显示：光标停留超过 show_ms 后才弹出浮窗
              local show_ms = picker.opts._float_show_ms or 500
              local show_timer = uv.new_timer()
              state.show_timer = show_timer
              show_timer:start(show_ms, 0, vim.schedule_wrap(function()
                -- 计时器已被取代（光标已移走），不显示
                if state.show_timer ~= show_timer then return end
                -- 焦点已离开 explorer
                if vim.api.nvim_get_current_win() ~= list_win then return end
                state.show_timer = nil
                cancel(show_timer)

                -- Reuse scratch buffer to reduce GC pressure
                local buf = state.buf
                if not buf or not vim.api.nvim_buf_is_valid(buf) then
                  buf = vim.api.nvim_create_buf(false, true)
                  state.buf = buf
                end
                vim.api.nvim_buf_set_lines(buf, 0, -1, false, { " " .. name .. " " })

                local cursor = vim.api.nvim_win_get_cursor(list_win)
                local float_win = vim.api.nvim_open_win(buf, false, {
                  relative = "win",
                  win = list_win,
                  row = cursor[1] - 1,
                  col = win_width,
                  width = vim.api.nvim_strwidth(name) + 2,
                  height = 1,
                  style = "minimal",
                  border = "rounded",
                  focusable = false,
                  zindex = 100,
                })

                state.win = float_win

                -- 自动隐藏计时器
                local hide_ms = picker.opts._float_hide_ms or 3000
                if hide_ms > 0 then
                  local hide_timer = uv.new_timer()
                  state.timer = hide_timer
                  hide_timer:start(hide_ms, 0, vim.schedule_wrap(function()
                    if state.timer ~= hide_timer then return end
                    cancel(hide_timer) state.timer = nil
                    if state.win and vim.api.nvim_win_is_valid(state.win) then
                      vim.api.nvim_win_close(state.win, true) state.win = nil
                    end
                  end))
                end
              end))
            end,
          },
        },
      },
    },
    keys = {
      { "<leader>e", function() Snacks.explorer() end, desc = "Toggle explorer" },
      { "<leader>ns", function() Snacks.scratch() end, desc = "Scratch (persistent)" },
      { "<leader>nN", function() vim.cmd("enew") vim.bo.buftype = "nofile" vim.bo.bufhidden = "wipe" end, desc = "New temp buffer" },
      { "<leader>gg", function() Snacks.terminal("lazygit") end, desc = "Lazygit" },
      { "<leader>gG", function() Snacks.terminal("lazygit", { cwd = vim.fn.expand("%:p:h") }) end, desc = "Lazygit (file dir)" },
      { "<leader>'", function() Snacks.terminal() end, desc = "Terminal" },

      -- Picker (migrated from fzf-lua)
      { "<leader>f", function() Snacks.picker.files() end, desc = "Find files" },
      { "<leader><leader>", function() Snacks.picker.grep() end, desc = "Live grep" },
      { "<Space>f", function() Snacks.picker.files({ cwd = vim.fn.expand("%:p:h") }) end, desc = "Find files (current dir)" },
      { "<Space>s", function() Snacks.picker.grep() end, desc = "Search text" },
      { "<Space>b", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<Space>r", function() Snacks.picker.recent() end, desc = "Recent files" },
      { "<Space>h", function() Snacks.picker.help() end, desc = "Help tags" },
      { "<Space>/", function() Snacks.picker.lines() end, desc = "Search in buffer" },
      { "<Space>dd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics list" },
      { "<Space>tt", function() Snacks.picker.colorschemes() end, desc = "Switch theme" },
      { "<Space>gc", function() Snacks.picker.git_log() end, desc = "Git commits" },
      { "<Space>gs", function() Snacks.picker.git_status() end, desc = "Git status" },
      { "<Space>km", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    },
  },
}
