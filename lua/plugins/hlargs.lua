---@type LazySpec
return {
  "m-demare/hlargs.nvim",
  cond = not (vim.g.vscode or vim.g.neovide),
  event = "User AstroFile",
  opts = {
    color = "#FF7A00",
    paint_arg_usages = true,
  },
}
