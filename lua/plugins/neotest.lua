local prefix = "<Leader>n"
---@type LazySpec
return {
  "nvim-neotest/neotest",
  cond = not vim.g.vscode,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-python",
    "rouge8/neotest-rust",
    "antoinemadec/FixCursorHold.nvim",
  },
  opts = function()
    return {
      adapters = {
        require("neotest-go"),
        require("neotest-rust"),
        require("neotest-python"),
      },
    }
  end,
  config = function(_, opts)
    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)
    require("neotest").setup(opts)
  end,
  specs = {
    { "AstroNvim/astroui", opts = { icons = { Neotest = "" } } },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n[prefix] = { desc = require("astroui").get_icon("Neotest", 1, false) .. "Neotest" }
        maps.n[prefix .. "r"] = { function() require("neotest").run.run() end, desc = "Run nearest test" }
        maps.n[prefix .. "f"] = {
          function() require("neotest").run.run(vim.fn.expand("%")) end,
          desc = "Run tests in current file",
        }
        maps.n[prefix .. "S"] = { function() require("neotest").run.stop() end, desc = "Stop running test" }
        maps.n[prefix .. "d"] = {
          function() require("neotest").run.run { strategy = "dap", suite = false } end,
          desc = "Run test in debugger",
        }
        maps.n[prefix .. "a"] = { function() require("neotest").run.attach() end, desc = "Attach to running test" }
        maps.n[prefix .. "s"] = {
          function() require("neotest").summary.toggle() end,
          desc = "Toggle test summary window",
        }
        maps.n[prefix .. "o"] = {
          function() require("neotest").output.open { enter = true } end,
          desc = "Show test output",
        }
        maps.n[prefix .. "O"] = {
          function() require("neotest").output_panel.toggle() end,
          desc = "Toggle test output window",
        }
        maps.n[prefix .. "k"] = {
          function() require("neotest").jump.prev { status = "failed" } end,
          desc = "Jump to previous failed test",
        }
        maps.n[prefix .. "j"] = {
          function() require("neotest").jump.next { status = "failed" } end,
          desc = "Jump to next failed test",
        }
      end,
    },
  },
}
