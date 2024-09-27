---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter-context",
  cond = not vim.g.vscode,
  event = "User Astrofile",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    max_lines = 1,
  },
}
