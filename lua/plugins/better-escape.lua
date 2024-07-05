---@type LazySpec
return {
  "max397574/better-escape.nvim",
  cond = not vim.g.vscode,
  opts = function(_, opts)
    local esc_fn = function()
      if vim.bo.filetype == "OverseerForm" then
        return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>lx" or "<esc>x"
      end
      return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>"
    end
    opts.mappings = {
      i = {
        j = {
          -- These can all also be functions
          k = esc_fn,
          j = esc_fn,
        },
      },
      c = {
        j = {
          k = esc_fn,
          j = esc_fn,
        },
      },
      t = {
        j = {
          k = esc_fn,
          j = esc_fn,
        },
      },
      v = {
        j = {
          k = esc_fn,
        },
      },
      s = {
        j = {
          k = esc_fn,
        },
      },
    }
  end,
}
