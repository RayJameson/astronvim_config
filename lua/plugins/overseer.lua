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
                [prefix .. "t"] = { "<Cmd>OverseerRun file-run-tab<CR>", desc = "Run file" },
              },
            },
          })
        end,
      },
    },
    opts = function()
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

      local function tab_builder()
        local file = vim.fn.expand("%:p")
        local cmd = filetype_to_cmd[vim.bo.filetype](file)
        return {
          cmd = cmd,
          strategy = {
            "toggleterm",
            direction = "tab",
            open_on_start = true,
            on_create = function() vim.cmd("stopinsert") end,
          },
          components = {
            { "display_duration", detail_level = 2 },
            "on_output_summarize",
            "on_exit_set_status",
            { "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
          },
        }
      end

      local function builder()
        local file = vim.fn.expand("%:p")
        local cmd = filetype_to_cmd[vim.bo.filetype](file)
        return {
          cmd = cmd,
          strategy = { "toggleterm", open_on_start = true },
          components = {
            { "display_duration", detail_level = 2 },
            "on_output_summarize",
            "on_exit_set_status",
            { "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
          },
        }
      end

      return {
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
              ["dd"] = "<Cmd>OverseerQuickAction dispose<CR>",
            },
          },
        },
        templates = {
          {
            name = "file-run",
            builder = builder,
            condition = {
              filetype = vim.tbl_keys(filetype_to_cmd),
            },
            desc = "Run single file",
          },
          {
            name = "file-run-tab",
            builder = tab_builder,
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
        },
      }
    end,
    config = function(_, opts)
      require("overseer").setup(opts.setup)
      vim.tbl_map(require("overseer").register_template, opts.templates)
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
  },
}
