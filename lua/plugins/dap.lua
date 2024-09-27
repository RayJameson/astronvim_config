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
        maps.n["<Leader>da"] = { function() require("dap").step_back() end, desc = "Step Back (S-F9)" }
        maps.n["<S-F9>"] = { function() require("dap").step_back() end, desc = "Step Back (S-F9)" }
        maps.n["<Leader>dd"] = { function() require("dap").disconnect() end, desc = "Disconnect" }
        maps.n["<C-F5>"] = { function() require("dap").restart_frame() end, desc = "Restart" } -- Control+F5
        maps.n["<S-F5>"] = { function() require("dap").terminate() end, desc = "Stop" } -- Shift+F5
        maps.n["<Leader>dh"] = {
          ---@diagnostic disable-next-line: missing-fields
          function() require("dapui").eval(nil, { enter = true }) end,
          desc = "Hover",
        }
        maps.n["<S-F8>"] = { -- Shift+F8
          function()
            vim.ui.input({ prompt = "Condition: " }, function(condition)
              if condition then require("dap").set_breakpoint(condition) end
            end)
          end,
          desc = "Conditional Breakpoint",
        }

        maps.n["<F11>"] = false
      end,
    },
  },
  dependencies = {
    { "theHamsta/nvim-dap-virtual-text", config = true },
    {
      "rcarriga/nvim-dap-ui",
      config = function(plugin, opts)
        opts.controls = { enabled = false }
        opts.icons = {
          collapsed = "",
          current_frame = "",
          expanded = "",
        }
        opts.layouts = {
          {
            -- You can change the order of elements in the sidebar
            elements = {
              -- Provide IDs as strings or tables with "id" and "size" keys
              {
                id = "scopes",
                size = 0.25, -- Can be float or integer > 1
              },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left", -- Can be "left" or "right"
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 9,
            position = "bottom", -- Can be "bottom" or "top"
          },
        }
        require("astronvim.plugins.configs.nvim-dap-ui")(plugin, opts)
      end,
    },
  },
}
