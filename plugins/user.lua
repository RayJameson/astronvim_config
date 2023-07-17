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
    event = "User Astrofile",
    cmd = "FormatModifications",
  },
  {
    "m-demare/hlargs.nvim",
    event = "LspAttach",
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
      vim.keymap.set("i", "<C-g>", function() return vim.fn["codeium#Accept"]() end, { expr = true })
      vim.keymap.set("i", "<C-;>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true })
      vim.keymap.set("i", "<C-,>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true })
      vim.keymap.set("i", "<C-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "User Astrofile",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {}
  },
  {
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
    ft = "qf",
    opts = {
      preview = {
        winblend = 0,
      },
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
      n_lines = 500,
      silent = true,
    },
  },
  {
    "mechatroner/rainbow_csv",
    ft = { "csv", "tsv" },
    event = "User AstroFile",
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "User AstroFile",
  },
}
