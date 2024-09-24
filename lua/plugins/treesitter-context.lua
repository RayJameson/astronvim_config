---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter-context",
  specs = {
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["<Leader>uD"] = {
              function() require("notify").dismiss { silent = true, pending = true } end,
              desc = "Dismiss notification",
            },
          },
        },
      },
    },
  },
  cond = not vim.g.vscode,
  event = "User Astrofile",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    max_lines = 1,
  },
}
