local prefix = "<Leader>r"
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
    specs = {
      { "AstroNvim/astroui", opts = { icons = { Overseer = "󰜎" } } },
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          return require("astrocore").extend_tbl(opts, {
            mappings = {
              n = {
                [prefix] = { desc = require("astroui").get_icon("Overseer", 1, false) .. "Overseer" },
                [prefix .. "i"] = { "<Cmd>OverseerInfo<CR>", desc = "Open Info" },
                [prefix .. "r"] = { "<Cmd>OverseerRun<CR>", desc = "Open tasks" },
                [prefix .. "<CR>"] = { "<Cmd>OverseerToggle<CR>", desc = "Open Panel" },
                [prefix .. "s"] = { "<Cmd>OverseerRun shell<CR>", desc = "Run shell" },
                [prefix .. "f"] = { "<Cmd>OverseerRun file-run<CR>", desc = "Run file" },
                [prefix .. "F"] = { "<Cmd>OverseerRun file-run-background<CR>", desc = "Run file in background" },
                [prefix .. "t"] = { "<Cmd>OverseerRun file-run-tab<CR>", desc = "Run file in new tab" },
                [prefix .. "l"] = { "<Cmd>OverseerLoadBundle<CR>", desc = "Load task bundle" },
              },
            },
          })
        end,
      },
    },
    opts = {
      strategy = "toggleterm",
      task_list = {
        direction = "bottom",
        max_height = { 100, 0.99 },
        height = 100,
        max_width = { 100, 0.2 },
        min_width = { 10, 0.1 },
        width = 20,
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
          ["dd"] = "<Cmd>OverseerQuickAction dispose<CR>",
        },
      },
    },
    config = function(_, opts)
      --- Run with runner
      ---@param runner string | table
      ---@return function
      local function run_with(runner)
        vim.validate { runner = { runner, { "table", "string" } } }
        return function(file)
          if type(runner) == "string" then
            return { runner, file }
          elseif type(runner) == "table" then
            return vim.list_extend(runner, { file })
          end
        end
      end

      local filetype_to_cmd = {
        python = function(file)
          return run_with("python")(file), { env = { PYTHONPATH = table.concat({ vim.uv.cwd(), "src" }, ":") } }
        end,
        sh = run_with("sh"),
        zsh = run_with("zsh"),
        bash = run_with("bash"),
        javascript = run_with("node"),
        typescript = run_with("node"),
        lua = run_with("luaj"),
        perl = run_with("perl"),
        html = run_with("xdg-open"),
        go = run_with { "go", "run" },
      }

      ---@param run_in_foreground boolean
      ---@param direction "dock"|"float"|"tab"|"vertical"|"horizontal"
      ---@return fun(): overseer.TaskDefinition
      local function create_builder(run_in_foreground, direction)

        ---@return overseer.TaskDefinition
        local function builder()
          local file = vim.fn.expand("%:p")
          local cmd = filetype_to_cmd[vim.bo.filetype](file)
          local task = {
            cmd = cmd,
            strategy = {
              "toggleterm",
              on_create = function() vim.cmd.stopinsert() end,
              direction = direction,
            },
            components = {
              { "display_duration", detail_level = 2 },
              "on_output_summarize",
              "on_exit_set_status",
              { "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
            },
          }
          if run_in_foreground then
            task.strategy.open_on_start = true
          else
            task.strategy.open_on_start = false
          end
          return task
        end

        return builder
      end
      require("overseer").setup(opts)
      vim.tbl_map(require("overseer").register_template, {
        {
          name = "file-run-background",
          builder = create_builder(false, "dock"),
          condition = {
            filetype = vim.tbl_keys(filetype_to_cmd),
          },
          desc = "Run single file in background",
        },
        {
          name = "file-run",
          builder = create_builder(true, "float"),
          condition = {
            filetype = vim.tbl_keys(filetype_to_cmd),
          },
          desc = "Run single file",
        },
        {
          name = "file-run-tab",
          builder = create_builder(true, "tab"),
          condition = {
            filetype = vim.tbl_keys(filetype_to_cmd),
          },
          desc = "Run single file in a new tab",
        },
        {
          name = "python run module",
          builder = function()
            local python_module, _ = vim.fn.expand("%:p:.:r"):gsub("/", ".")
            return {
              cmd = { "python3" },
              args = { "-m", python_module },
              env = { PYTHONPATH = "src" .. ":" .. vim.uv.cwd() },
              strategy = {
                "toggleterm",
                open_on_start = true,
                direction = "tab",
              },
            }
          end,
          condition = { filetype = "python" },
          desc = "Run with `-m` flag",
        },
      })
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
  },
}
