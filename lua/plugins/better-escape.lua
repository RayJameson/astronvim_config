---@type LazySpec
return {
  "max397574/better-escape.nvim",
  opts = function()
    local esc_fn = function()
      if vim.bo.filetype == "OverseerForm" then
        return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<Esc>lx" or "<Esc>x"
      end
      return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<Esc>l" or "<Esc>"
    end
    local disabled = {
      j = { j = false, k = false },
      k = { j = false, k = false },
    }
    return {
      create_default_mappings = false,
      mappings = {
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
        t = disabled,
        v = disabled,
        x = disabled,
        s = disabled,
      },
    }
  end,
}
