-- Input method auto-switching for Chinese users
-- Requires: brew tap laishulu/homebrew && brew install macism
return {
  {
    "keaising/im-select.nvim",
    event = "InsertEnter",
    config = function()
      require("im_select").setup({
        -- macism is the only CLI that reliably switches CJK input on macOS
        default_command = "macism",
        -- Switch to English (ABC) in Normal mode
        default_im_select = "com.apple.keylayout.ABC",
        -- Async switching to avoid blocking on mode change
        async_switch_im = true,
      })
    end,
  },
}
