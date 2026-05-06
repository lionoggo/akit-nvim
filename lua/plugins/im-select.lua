-- Input method auto-switching for Chinese users
-- macOS: im-select, Linux: fcitx5-remote or ibus

local is_mac = vim.fn.has("mac") == 1
local is_linux = vim.fn.has("linux") == 1

local function detect_linux_im_backend()
  if vim.fn.executable("fcitx5-remote") == 1 then
    return "fcitx5"
  end
  if vim.fn.executable("ibus") == 1 then
    return "ibus"
  end
  return nil
end

return {
  {
    "keaising/im-select.nvim",
    event = "InsertEnter",
    cond = function()
      if is_mac then
        return vim.fn.executable("im-select") == 1
      end
      if is_linux then
        return detect_linux_im_backend() ~= nil
      end
      return false
    end,
    config = function()
      local cfg

      if is_mac then
        cfg = {
          default_command = "im-select",
          default_im_select = "com.apple.keylayout.ABC",
          set_default_events = { "InsertLeave" }, -- CmdlineLeave handled by autocmds.lua to allow restore
          set_previous_events = {}, -- disable InsertEnter restore to avoid conflict with Karabiner Shift-switch
          async_switch_im = true,
        }
      elseif is_linux then
        local backend = detect_linux_im_backend()
        if backend == "fcitx5" then
          cfg = {
            default_command = "fcitx5-remote",
            default_im_select = "1",
            default_prev_im_select = "2",
            async_switch_im = true,
          }
        elseif backend == "ibus" then
          cfg = {
            default_command = "ibus",
            default_im_select = "xkb:us::eng",
            default_prev_im_select = "rime",
            async_switch_im = true,
          }
        end
      end

      if cfg then
        require("im_select").setup(cfg)
      end
    end,
  },
}
