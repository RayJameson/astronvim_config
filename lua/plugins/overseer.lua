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
        mappings = {
          n = {
            [prefix] = { desc = "󱁤 Compilation" },
            [prefix .. "a"] = { "<Cmd>OverseerQuickAction<CR>", desc = "Quick Action" },
            [prefix .. "i"] = { "<Cmd>OverseerInfo<CR>", desc = "Overseer Info" },
            [prefix .. "<CR>"] = { "<Cmd>OverseerToggle<CR>", desc = "Overseer" },
            [prefix .. "r"] = { "<Cmd>OverseerRun<CR>", desc = "Run" },
          },
        },
      },
    },
    opts = {
      setup = {
        task_list = {
          strategy = "toggleterm",
          direction = "bottom",
          max_height = { 100, 0.99 },
          height = 100,
          bindings = {
            ["<C-l>"] = false,
            ["<C-h>"] = false,
            ["<C-k>"] = false,
            ["<C-j>"] = false,
            ["p"] = false,
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
