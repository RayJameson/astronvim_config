---@type LazySpec
return {
  "mrjones2014/smart-splits.nvim",
  ---@type LazySpec
  specs = {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings
      maps.n["<M-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
      maps.n["<M-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
      maps.n["<M-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
      maps.n["<M-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }
    end,
  },
}
