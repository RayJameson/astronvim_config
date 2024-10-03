---@type LazySpec
return {
  "aznhe21/actions-preview.nvim",
  optional = true,
  opts = function(_, opts)
    opts.highlight_command = {
      require("actions-preview.highlight").diff_so_fancy(nil, "less --tabs=4 -RFX"),
    }
    opts.telescope = {
      sorting_strategy = "ascending",
      layout_strategy = "vertical",
      layout_config = {
        width = 0.8,
        height = 0.9,
        prompt_position = "top",
        preview_cutoff = 20,
        preview_height = function(_, _, max_lines) return max_lines - 15 end,
      },
    }
  end,
}
