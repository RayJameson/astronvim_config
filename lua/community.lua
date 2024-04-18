-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  -- { import = "astrocommunity.colorscheme.catppuccin" },
  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
  { import = "astrocommunity.recipes.heirline-vscode-winbar" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.go" },
  {
    "ray-x/go.nvim",
    cond = not (vim.g.neovide or vim.g.vscode),
    opts = {
      lsp_inlay_hints = {
        enable = false,
      },
    },
  },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  {
    "todo-comments.nvim",
    cond = not vim.g.vscode,
    opts = {
      keywords = {
        TEST = {
          icon = " ",
          color = "test",
          alt = { "TESTING", "TEST PASSED", "TEST FAILED" },
        },
      },
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = "#61afef",
        hint = "#10B981",
        default = "#c882e7",
        test = "#cbcb41",
      },
    },
  },
  { import = "astrocommunity.project.nvim-spectre" },
  {
    "nvim-spectre",
    cond = not vim.g.vscode,
    opts = function(_, opts)
      opts.open_cmd = "tabnew"
      opts.highlight = {
        ui = "String",
        search = "DiffRemoved",
        replace = "DiffAdded",
      }
      opts.line_sep_start = ""
      opts.result_padding = "│  "
      opts.line_sep = ""
    end,
  },
  { import = "astrocommunity.indent.mini-indentscope" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  {
    "trouble.nvim",
    cond = not vim.g.vscode,
    opts = {
      include_declaration = { "lsp_definitions" },
      auto_jump = { "lsp_definitions", "lsp_references", "lsp_implementations" },
      action_keys = {
        jump_close = { "o", "<CR>" },
        jump = { "<tab>", "<2-leftmouse>" },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "trouble",
        callback = function()
          local next = require("trouble").next
          local previous = require("trouble").previous
          local maps = { n = {} }
          maps.n["<M-j>"] = {
            function() next {} end,
            desc = "Jump to next entry",
          }
          maps.n["<M-k>"] = {
            function() previous {} end,
            desc = "Jump to previous entry",
          }
          maps.n["j"] = {
            function() next { skip_groups = true } end,
            desc = "Jump to next entry",
          }
          maps.n["k"] = {
            function() previous { skip_groups = true } end,
            desc = "Jump to previous entry",
          }
          require("astrocore").set_mappings(maps, { buffer = 0 })
        end,
        group = vim.api.nvim_create_augroup("TroubleMappings", { clear = true }),
      })
    end,
  },
}
