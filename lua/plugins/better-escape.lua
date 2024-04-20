---@type LazySpec
return {
  "max397574/better-escape.nvim",
  cond = not vim.g.vscode,
  opts = function(_, opts)
    opts.mapping = { "JK", "JJ", "jk", "jj" }
    opts.keys = function() return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>" end
  end,
}
