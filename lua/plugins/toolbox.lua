return {
  "DanWlker/toolbox.nvim",
  lazy = true,
  specs = {
    {
      "AstroNvim/astroui",
      ---@type AstroUIOpts
      opts = { icons = { Toolbox = "󱁤" } },
    },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        return require("astrocore").extend_tbl(opts, {
          mappings = {
            n = {
              ["<Leader>T"] = {
                function() require("toolbox").show_picker() end,
                desc = require("astroui").get_icon("Toolbox", 1, true) .. "Toolbox",
              },
            },
            x = {
              ["<Leader>T"] = {
                function() require("toolbox").show_picker() end,
                desc = require("astroui").get_icon("Toolbox", 1, true) .. "Toolbox",
              },
            },
          },
        })
      end,
    },
  },
  dependencies = { "nvim-telescope/telescope.nvim" },
  opts = {
    commands = {
      {
        name = "Format Json",
        execute = "!jq",
      },
      {
        name = "Print Lua table",
        execute = function(v) print(vim.inspect(v)) end,
      },
      {
        name = "Copy relative path to clipboard",
        execute = function()
          local path = vim.fn.expand("%")
          vim.fn.setreg("+", path)
        end,
      },
      {
        name = "Copy absolute path to clipboard",
        execute = function()
          local path = vim.fn.expand("%:p")
          vim.fn.setreg("+", path)
        end,
      },
      {
        name = "Substitute limited to visual selection",
        execute = [[:s/\%V]],
        require_input = true,
      },
      {
        name = "Substitute in `very magic` mode",
        execute = [[:s/\v]],
        require_input = true,
      },
    },
  },
}
