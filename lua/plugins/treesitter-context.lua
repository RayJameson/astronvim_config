---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "User Astrofile",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    max_lines = 1,
  },
}
