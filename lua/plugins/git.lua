return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Hunk navigation
        map("n", "]h", gs.next_hunk, "Next hunk")
        map("n", "[h", gs.prev_hunk, "Prev hunk")

        -- Space leader git actions
        map("n", "<Space>gp", gs.preview_hunk, "Preview hunk")
        map("n", "<Space>gb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("n", "<Space>gr", gs.reset_hunk, "Reset hunk")
        map("n", "<Space>gS", gs.stage_hunk, "Stage hunk")
        map("n", "<Space>gu", gs.undo_stage_hunk, "Undo stage hunk")
      end,
    },
  },
}
