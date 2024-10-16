local M = {}

---Calculate percent of base number
---@param base_number integer | number should be positive number
---@param percents_of_base integer
---@return integer
function M.calculate_percent(base_number, percents_of_base)
  assert(base_number > 0, "Base number in `calculate_percent` should be positive")
  local _1_percent = base_number / 100
  local result = math.floor(percents_of_base * _1_percent)
  return result
end

return M
