---@type LazySpec
return {
  "rcarriga/nvim-notify",
  specs = {
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["[c"] = { function() require("treesitter-context").go_to_context() end, desc = "Go to context" },
          },
        },
      },
    },
  },
  opts = {
    background_colour = "#000000",
    stages = "fade",
    fps = 60,
    timeout = 0,
  },
}
