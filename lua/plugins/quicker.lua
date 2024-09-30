return {
  "stevearc/quicker.nvim",
  event = "VeryLazy",
  specs = {
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["<Leader>xq"] = { function() require("quicker").toggle { focus = true } end, desc = "Toggle quickfix" },
            ["<Leader>xl"] = {
              function() require("quicker").toggle { focus = true, loclist = true } end,
              desc = "Toggle loclist",
            },
          },
        },
      },
    },
  },
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {
    max_filename_width = function() return math.floor(math.min(95, vim.o.columns / 3)) end,
    borders = {
      vert = "│",
      -- Strong headers separate results from different files
      strong_header = "─",
      strong_cross = "┼",
      strong_end = "┤",
      -- Soft headers separate results within the same file
      soft_header = "─",
      soft_cross = "┼",
      soft_end = "┤",
    },
    type_icons = {
      E = " ",
      W = " ",
      I = " ",
      N = "󱞁 ",
      H = " ",
    },
    keys = {
      {
        ">",
        function() require("quicker").expand { before = 2, after = 2, add_to_existing = true } end,
        desc = "Expand quickfix context",
      },
      {
        "<",
        function() require("quicker").collapse() end,
        desc = "Collapse quickfix context",
      },
    },
  },
}
