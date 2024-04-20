---@type LazySpec
return {
  "lukas-reineke/indent-blankline.nvim",
  cond = not vim.g.vscode,
  opts = function(_, opts) require("astrocore").extend_tbl(opts.filetype_exclude, { "oil" }) end,
}
