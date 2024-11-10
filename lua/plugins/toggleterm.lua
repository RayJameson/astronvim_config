---@type LazySpec
return {
  "akinsho/toggleterm.nvim",
  optional = true,
  opts = {
    direction = "float",
    autochdir = true,
    float_opts = {
      width = function() return require("utilities").calculate_percent(vim.api.nvim_win_get_width(0), 95) end,
      height = function() return require("utilities").calculate_percent(vim.api.nvim_win_get_height(0), 95) end,
    },
  },
}
