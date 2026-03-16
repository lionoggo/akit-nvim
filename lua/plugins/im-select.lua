-- Input method auto-switching for Chinese users
-- Requires: brew install im-select
return {
  {
    "keaising/im-select.nvim",
    event = "InsertEnter",
    config = function()
      require("im_select").setup({
        default_command = "im-select",
        -- Switch to English (ABC) in Normal mode
        default_im_select = "com.apple.keylayout.ABC",
        -- Restore Squirrel (RIME) when entering Insert mode
        default_prev_im_select = "im.rime.inputmethod.Squirrel.Hans",
        -- Async switching to avoid blocking on mode change
        async_switch_im = true,
      })
    end,
  },
}
