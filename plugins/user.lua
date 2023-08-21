return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  {
    "simrat39/rust-tools.nvim",
    opts = { tools = { inlay_hints = { auto = false } } },
  },
  {
    "joechrisellis/lsp-format-modifications.nvim",
    event = "User AstroGitfile",
    cmd = "FormatModifications",
  },
  {
    "m-demare/hlargs.nvim",
    event = "User AstroFile",
    opts = {
      color = "#FF7A00", --"#ef9062",
      paint_arg_usages = true,
    },
  },
  {
    "Exafunction/codeium.vim",
    event = "LspAttach",
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set("i", "<M-g>", function() return vim.api.nvim_call_function("codeium#Accept", {}) end, { expr = true })
      vim.keymap.set("i", "<M-;>", function() return vim.api.nvim_call_function("codeium#CycleCompletions", {1}) end, { expr = true })
      vim.keymap.set("i", "<M-,>", function() return vim.api.nvim_call_function("codeium#CycleCompletions", {-1}) end, { expr = true })
      vim.keymap.set("i", "<M-x>", function() return vim.api.nvim_call_function("codeium#Clear", {}) end, { expr = true })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "User Astrofile",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
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
    "mechatroner/rainbow_csv",
    ft = { "csv", "tsv" },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "User AstroFile",
    config = function(_, opts) require("rainbow-delimiters.setup")(opts) end,
  },
  {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    cmd = {
      "DevdocsFetch",
      "DevdocsInstall",
      "DevdocsUninstall",
      "DevdocsOpen",
      "DevdocsOpenFloat",
      "DevdocsUpdate",
      "DevdocsUpdateAll",
    },
  },
  {
    "almo7aya/openingh.nvim",
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
}
