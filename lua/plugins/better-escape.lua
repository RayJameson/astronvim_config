---@type LazySpec
return {
  "max397574/better-escape.nvim",
  cond = not vim.g.vscode,
  opts = function(_, opts)
    local esc_fn = function()
      if vim.bo.filetype == "OverseerForm" then
        return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<Esc>lx" or "<Esc>x"
      end
      return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<Esc>l" or "<Esc>"
    end
    opts.mappings = {
      i = {
        j = {
          k = esc_fn,
        },
      },
      c = {
        j = {
          k = esc_fn,
        },
      },
      t = {
        j = {
          k = "<C-\\><C-n>",
        },
      },
      v = {},
      s = {
        j = {
          k = esc_fn,
        },
      },
    }
  end,
}
