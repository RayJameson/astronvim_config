local icon = vim.g.icons_enabled and " " or ""
local prefix = "<Leader>D"
require("astrocore").set_mappings {
  n = { [prefix] = { name = icon .. "Diff View" } },
  x = { [prefix] = { name = icon .. "Diff View" } },
}
---@type LazySpec
return {
  "sindrets/diffview.nvim",
  event = "User AstroGitFile",
  keys = {
    { prefix .. "<CR>", "<cmd>DiffviewOpen<cr>", desc = "Open DiffView" },
    { prefix .. "h", "<cmd>DiffviewFileHistory %<cr>", desc = "Open DiffView File History", mode = { "n", "x" } },
    { prefix .. "H", "<cmd>DiffviewFileHistory<cr>", desc = "Open DiffView Branch History" },
  },
  cmd = {
    "DiffviewOpen",
    "DiffviewFileHistory",
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = { winbar_info = true },
      file_history = { winbar_info = true },
      merge_tool = { layout = "diff3_mixed" },
    },
    keymaps = {
      view = {
        { "n", "q", ":DiffviewClose<CR>", { desc = "Close Diffview" } },
      },
      file_history_panel = {
        { "n", "q", ":DiffviewClose<CR>", { desc = "Close Diffview" } },
      },
      file_panel = {
        { "n", "q", ":DiffviewClose<CR>", { desc = "Close Diffview" } },
      },
    },
    hooks = { diff_buf_read = function(bufnr) vim.b[bufnr].view_activated = false end },
  },
}
