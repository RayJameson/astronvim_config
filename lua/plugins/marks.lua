---@type LazySpec
return {
  "chentoast/marks.nvim",
  cond = not vim.g.vscode,
  event = "User AstroFile",
  opts = {
    excluded_filetypes = {
      "qf",
      "NvimTree",
      "toggleterm",
      "TelescopePrompt",
      "alpha",
      "netrw",
      "neo-tree",
      "oil",
    },
  },
}
