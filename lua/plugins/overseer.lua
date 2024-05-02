local prefix = "<Leader>o"
---@type LazySpec
return {
  {
    "stevearc/overseer.nvim",
    cmd = {
      "OverseerOpen",
      "OverseerClose",
      "OverseerToggle",
      "OverseerSaveBundle",
      "OverseerLoadBundle",
      "OverseerDeleteBundle",
      "OverseerRunCmd",
      "OverseerRun",
      "OverseerInfo",
      "OverseerBuild",
      "OverseerQuickAction",
      "OverseerTaskAction",
      "OverseerClearCache",
    },
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        commands = {
          AutoCompile = {
            function()
              require("overseer").run_template({ name = "compile with compiler" }, function(task)
                if task then
                  task:add_component { "restart_on_save", paths = { vim.fn.expand("%:p") } }
                else
                  vim.notify("Error setting up auto compilation", vim.log.levels.ERROR)
                end
              end)
            end,
            desc = "Automatically compile the current file with `compiler` on save",
          },
          Compile = {
            function() require("overseer").run_template { name = "compile with compiler" } end,
            desc = "Compile the current file with `compiler`",
          },
          OpOut = {
            function() require("overseer").run_template { name = "view file output" } end,
            desc = "View the current file ouptut with `opout`",
          },
          Present = {
            function()
              require("overseer").run_template({ name = "present with pdfpc" }, function(task)
                if not task then vim.notify("Unable to start presentation", vim.log.levels.ERROR) end
              end)
            end,
            desc = "Present the current file with `pdfpc`",
          },
        },
        mappings = {
          n = {
            [prefix] = { desc = "󱁤 Compilation" },
            [prefix .. "a"] = { "<Cmd>OverseerQuickAction<CR>", desc = "Quick Action" },
            [prefix .. "i"] = { "<Cmd>OverseerInfo<CR>", desc = "Overseer Info" },
            [prefix .. "c"] = { "<Cmd>Compile<CR>", desc = "Compile" },
            [prefix .. "C"] = { "<Cmd>AutoCompile<CR>", desc = "Auto Compile" },
            [prefix .. "<CR>"] = { "<Cmd>OverseerToggle<CR>", desc = "Overseer" },
            [prefix .. "p"] = { "<Cmd>Present<CR>", desc = "Present file output" },
            [prefix .. "r"] = { "<Cmd>OverseerRun<CR>", desc = "Run" },
            [prefix .. "v"] = { "<Cmd>OpOut<CR>", desc = "View Output" },
          },
        },
      },
    },
    opts = {
      setup = {
        task_list = {
          strategy = "toggleterm",
          direction = "left",
          bindings = {
            ["<C-l>"] = false,
            ["<C-h>"] = false,
            ["<C-k>"] = false,
            ["<C-j>"] = false,
            q = "<Cmd>close<CR>",
            K = "IncreaseDetail",
            J = "DecreaseDetail",
            ["<C-p>"] = "ScrollOutputUp",
            ["<C-n>"] = "ScrollOutputDown",
          },
        },
      },
    },
    config = function(_, opts)
      require("overseer").setup(opts.setup)
      -- vim.tbl_map(require("overseer").register_template, opts.templates)
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
  },
}
