local prefix = "<Leader><Leader>"
local maps = { n = {} }
local icon = vim.g.icons_enabled and "󰛢 " or ""
maps.n[prefix] = { desc = icon .. "Grapple" }
require("astrocore").set_mappings(maps)
---@type LazySpec
return {
  "cbochs/grapple.nvim",
  cond = not vim.g.vscode,
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "Grapple" },
  keys = {
    { prefix .. "t", "<cmd>Grapple toggle<CR>", desc = "Toggle a file" },
    { prefix .. "e", "<cmd>Grapple toggle_tags<CR>", desc = "Select from tags" },
    { prefix .. "s", "<cmd>Grapple toggle_scopes<CR>", desc = "Select a project scope" },
    { "<C-n>", "<cmd>Grapple cycle forward<CR>", desc = "Select next tag" },
    { "<C-p>", "<cmd>Grapple cycle backward<CR>", desc = "Select previous tag" },
  },
  opts = function(_, opts)
    opts.scope = "git_branch"
  end
}
