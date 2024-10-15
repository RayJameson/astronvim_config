---Calculate percent of base number
---@param base_number integer | number should be positive number
---@param percents_of_base integer
---@return integer
local function calculate_percent(base_number, percents_of_base)
  assert(base_number > 0, "Base number in `calculate_percent` should be positive")
  local _1_percent = base_number / 100
  local result = math.floor(percents_of_base * _1_percent)
  return result
end

---@type LazySpec
return {
  "akinsho/toggleterm.nvim",
  optional = true,
  opts = {
    direction = "float",
    autochdir = true,
    float_opts = {
      width = calculate_percent(vim.api.nvim_win_get_width(0), 95),
      height = calculate_percent(vim.api.nvim_win_get_height(0), 95),
    },
  },
}
