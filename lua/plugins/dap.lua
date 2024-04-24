---@type LazySpec
return {
  "mfussenegger/nvim-dap",
  cond = not vim.g.vscode,
  dependencies = { "theHamsta/nvim-dap-virtual-text", config = true },
}
