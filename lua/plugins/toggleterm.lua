---@type LazySpec
return {
  "akinsho/toggleterm.nvim",
  optional = true,
  opts = {
    direction = "float",
    autochdir = true,
    float_opts = {
      width = require("utilities").calculate_percent(vim.api.nvim_win_get_width(0), 95),
      height = require("utilities").calculate_percent(vim.api.nvim_win_get_height(0), 95),
    },
  },
}
