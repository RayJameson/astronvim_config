---@type LazySpec
return {
  "folke/which-key.nvim",
  optional = true,
  opts = {
    preset = "modern",
    delay = 0,
    triggers = {
      { "<auto>", mode = "nxso" },
    },
  },
}
