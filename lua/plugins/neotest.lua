local icon = vim.g.icons_enabled and " " or ""
local prefix = "<Leader>n"
local maps = { n = {} }
maps.n[prefix] = { desc = icon .. "Neotest" }
require("astrocore").set_mappings(maps)

---@type LazySpec
return {
  "nvim-neotest/neotest",
  cond = not vim.g.vscode,
  config = function()
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
    require("neotest").setup {
      adapters = {
        require("neotest-go"),
        require("neotest-rust"),
        require("neotest-python"),
      },
      log_level = vim.log.levels.DEBUG,
    }
    vim.api.nvim_create_user_command("NeotestRun", require("neotest").run.run, {})
    vim.api.nvim_create_user_command(
      "NeotestRunFile",
      function() require("neotest").run.run(vim.fn.expand("%")) end,
      {}
    )
    vim.api.nvim_create_user_command(
      "NeotestRunDap",
      function() require("neotest").run.run { strategy = "dap" } end,
      {}
    )
    vim.api.nvim_create_user_command("NeotestStop", function() require("neotest").run.stop() end, {})
    vim.api.nvim_create_user_command("NeotestAttach", function() require("neotest").run.attach() end, {})
    vim.api.nvim_create_user_command("NeotestSummaryToggle", function() require("neotest").summary.toggle() end, {})
    vim.api.nvim_create_user_command(
      "NeotestOutput",
      function() require("neotest").output.open { enter = true } end,
      {}
    )
    vim.api.nvim_create_user_command("NeotestOutputToggle", function() require("neotest").output_panel.toggle() end, {})
    vim.api.nvim_create_user_command(
      "NeotestJumpPreviousFailed",
      function() require("neotest").jump.prev { status = "failed" } end,
      {}
    )
    vim.api.nvim_create_user_command(
      "NeotestJumpNextFailed",
      function() require("neotest").jump.next { status = "failed" } end,
      {}
    )
  end,
  cmd = {
    "NeotestRun",
    "NeotestRunFile",
    "NeotestStop",
    "NeotestRunDap",
    "NeotestAttach",
    "NeotestSummaryToggle",
    "NeotestOutput",
    "NeotestOutputToggle",
    "NeotestJumpPreviousFailed",
    "NeotestJumpNextFailed",
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-python",
    "rouge8/neotest-rust",
    "antoinemadec/FixCursorHold.nvim",
  },
  keys = {
    { prefix .. "r", "<CMD>NeotestRun<CR>", desc = "Run nearest test" },
    { prefix .. "f", "<CMD>NeotestRunFile<CR>", desc = "Run tests in current file" },
    { prefix .. "S", "<CMD>NeotestStop<CR>", desc = "Stop running test" },
    { prefix .. "d", "<CMD>NeotestRunDap<CR>", desc = "Run test in debugger" },
    { prefix .. "a", "<CMD>NeotestAttach<CR>", desc = "Attach to running test" },
    { prefix .. "s", "<CMD>NeotestSummaryToggle<CR>", desc = "Toggle test summary window" },
    { prefix .. "o", "<CMD>NeotestOutput<CR>", desc = "Show test output" },
    { prefix .. "O", "<CMD>NeotestOutputToggle<CR>", desc = "Toggle test output window" },
    { prefix .. "k", "<CMD>NeotestJumpPreviousFailed<CR>", desc = "Jump to previous failed test" },
    { prefix .. "j", "<CMD>NeotestJumpNextFailed<CR>", desc = "Jump to next failed test" },
  },
}
