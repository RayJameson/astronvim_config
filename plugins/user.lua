return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  {
    "simrat39/rust-tools.nvim",
    cond = not vim.g.vscode,
    opts = { tools = { inlay_hints = { auto = false } } },
  },
  {
    "m-demare/hlargs.nvim",
    cond = not (vim.g.vscode or vim.g.neovide),
    event = "User AstroFile",
    opts = {
      color = "#FF7A00", --"#ef9062",
      paint_arg_usages = true,
    },
  },
  {
    "Exafunction/codeium.vim",
    cond = not vim.g.vscode,
    event = "LspAttach",
    config = function()
      -- stylua: ignore start
      vim.keymap.set("i", "<C-g>", function() return vim.api.nvim_call_function("codeium#Accept", {}) end, { expr = true })
      vim.keymap.set("i", "<C-;>", function() return vim.api.nvim_call_function("codeium#CycleCompletions", {1}) end, { expr = true })
      vim.keymap.set("i", "<C-,>", function() return vim.api.nvim_call_function("codeium#CycleCompletions", {-1}) end, { expr = true })
      vim.keymap.set("i", "<C-x>", function() return vim.api.nvim_call_function("codeium#Clear", {}) end, { expr = true })
      -- stylua: ignore end
      vim.keymap.set("n", "<leader>;", function()
        -- HACK: initially there is no vim.g.codeium_enabled variable even if Codeium enabled
        if vim.g.codeium_enabled == true or vim.g.codeium_enabled == nil then
          vim.cmd("CodeiumDisable")
        else
          vim.cmd("CodeiumEnable")
        end
      end, { noremap = true, desc = "Toggle Codeium" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    cond = not vim.g.vscode,
    event = "User Astrofile",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      max_lines = 5,
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {
      aliases = {
        ["b"] = { ")", "}", "]" },
      },
    },
  },
  {
    "echasnovski/mini.ai",
    event = { "User AstroFile", "InsertEnter" },
    opts = {
      silent = true,
      search_method = "cover_or_nearest",
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    cond = not vim.g.vscode,
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "User AstroFile",
    config = function(_, opts) require("rainbow-delimiters.setup")(opts) end,
  },
  {
    "luckasRanarison/nvim-devdocs",
    cond = not vim.g.vscode,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = {
      "DevdocsFetch",
      "DevdocsInstall",
      "DevdocsUninstall",
      "DevdocsOpen",
      "DevdocsOpenFloat",
      "DevdocsUpdate",
      "DevdocsUpdateAll",
    },
    keys = {
      { "<leader>fd", "<cmd>DevdocsOpenCurrentFloat<CR>", desc = "Find Devdocs for current ft", mode = { "n" } },
      { "<leader>fD", "<cmd>DevdocsOpenFloat<CR>", desc = "Find Devdocs", mode = { "n" } },
    },
    opts = {
      previewer_cmd = vim.fn.executable("glow") == 1 and "glow" or nil,
      cmd_args = { "-s", "dark", "-w", "80" },
      picker_cmd = true,
      picker_cmd_args = { "-s", "dark", "-w", "50" },
      float_win = { -- passed to nvim_open_win(), see :h api-floatwin
        relative = "editor",
        height = 35,
        width = 125,
        border = "rounded",
      },
    },
  },
  {
    "almo7aya/openingh.nvim",
    cond = not vim.g.vscode,
    cmd = { "OpenInGHRepo", "OpenInGHFile", "OpenInGHFileLines" },
    keys = function()
      local prefix = "<leader>g"
      return {
        { prefix .. "o", "<cmd>OpenInGHRepo<CR>", desc = "Open git repo in web", mode = { "n" } },
        { prefix .. "f", "<cmd>OpenInGHFile<CR>", desc = "Open git file in web", mode = { "n" } },
        { prefix .. "f", "<cmd>OpenInGHFileLines<CR>", desc = "Open git lines in web", mode = { "x" } },
      }
    end,
  },
  {
    "michaelb/sniprun",
    cond = not vim.g.vscode,
    -- there is error when using "<CR>" instead of ":" for visual mode mappings
    -- https://discord.com/channels/939594913560031363/1144604661693812771/1146789150981365761
    -- https://www.reddit.com/r/neovim/comments/y2h8ps/i_have_a_mapping_for_normal_how_to_make_an/
    keys = {
      { "<leader>rs", ":SnipRun<CR>", desc = "Run Snippet", mode = { "n", "x" } },
      { "<leader>rC", ":SnipClose<CR>", desc = "Close SnipRun", mode = { "n", "x" } },
    },
    opts = {},
    build = "bash ./install.sh 1",
    cmd = {
      "SnipRun",
      "SnipInfo",
      "SnipReset",
      "SnipReplMemoryClean",
      "SnipClose",
      "SnipLive",
    },
  },
  {
    "Wansmer/langmapper.nvim",
    lazy = false,
    priority = 1, -- High priority is needed if you will use `autoremap()`
    opts = {},
  },
}
