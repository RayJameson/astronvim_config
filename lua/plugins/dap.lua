---@type LazySpec
return {
  "mfussenegger/nvim-dap",
  cond = not vim.g.vscode,
  specs = {
    { "AstroNvim/astroui", opts = { icons = { Debugger = "" } } },
    {
      "AstroNvim/astrocore",
      opts = function(
        _,
        opts --[[@as AstroCoreOpts]]
      )
        local maps = opts.mappings
        maps.n["<Leader>d"] = { desc = require("astroui").get_icon("Debugger", 1, false) .. "Debugger" }
        maps.n["<F8>"] = { function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" }
        maps.n["<F9>"] = { function() require("dap").step_over() end, desc = "Step Over" }
        maps.n["<F10>"] = { function() require("dap").step_into() end, desc = "Step Into" }
        maps.n["<S-F10>"] = { function() require("dap").step_out() end, desc = "Step Out (S-F10)" } -- Shift+F10
        maps.n["<Leader>db"] = { function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint (F8)" }
        maps.n["<Leader>di"] = { function() require("dap").step_into() end, desc = "Step Into (F10)" }
        maps.n["<Leader>dO"] = { function() require("dap").step_out() end, desc = "Step Out (S-F10)" }
        maps.n["<Leader>do"] = { function() require("dap").step_over() end, desc = "Step Over (F9)" }
        maps.n["<Leader>dd"] = { function() require("dap").disconnect() end, desc = "Disconnect" }
        maps.n["<C-F5>"] = { function() require("dap").restart_frame() end, desc = "Debugger: Restart" } -- Control+F5
        maps.n["<S-F5>"] = { function() require("dap").terminate() end, desc = "Debugger: Stop" } -- Shift+F5
        maps.n["<S-F9>"] = { -- Shift+F9
          function()
            vim.ui.input({ prompt = "Condition: " }, function(condition)
              if condition then require("dap").set_breakpoint(condition) end
            end)
          end,
          desc = "Debugger: Conditional Breakpoint",
        }

        maps.n["<F11>"] = false
      end,
    },
  },
  dependencies = { "theHamsta/nvim-dap-virtual-text", config = true },
}
