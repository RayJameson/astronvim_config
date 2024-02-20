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
    "linrongbin16/gitlinker.nvim",
    cond = not vim.g.vscode,
    opts = function(_, _)
      return {
        router = {
          browse = {
            ["^github%..*%.com"] = require("gitlinker.routers").github_browse,
          },
          blame = {
            ["^github%..*%.com"] = require("gitlinker.routers").github_blame,
          },
        },
      }
    end,
    cmd = "GitLink",
    keys = function()
      local prefix = "<leader>g"
      return {
        { prefix .. "o", "<cmd>GitLink!<CR>", desc = "Open git line(s) in web", mode = { "n", "x" } },
        { prefix .. "O", "<cmd>GitLink<CR>", desc = "Copy git line(s) url", mode = { "n", "x" } },
      }
    end,
  },
}
