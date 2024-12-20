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
  { import = "astrocommunity.completion.cmp-nerdfont" },
  { import = "astrocommunity.completion.cmp-nvim-lua" },
  { import = "astrocommunity.completion.cmp-under-comparator" },
  --{ import = "astrocommunity.completion.blink-cmp" }, -- very fast, but I'm lazy to redo my cmp config
  { import = "astrocommunity.completion.magazine-nvim" }, -- this one is fast too
  { import = "astrocommunity.recipes.heirline-vscode-winbar" },
  (vim.fn.executable("rustc") and { import = "astrocommunity.pack.rust" }) or {},
  (vim.fn.executable("go") == 1 and { import = "astrocommunity.pack.go" }) or {},
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.editing-support.bigfile-nvim" },
  { import = "astrocommunity.quickfix.nvim-bqf" },
  { import = "astrocommunity.quickfix.quicker-nvim" },
  {
    "nvim-bqf",
    optional = true,
    opts = {
      preview = {
        winblend = 0,
        auto_resize_height = true,
        win_height = 999,
      },
    },
  },
  {
    "todo-comments.nvim",
    optional = true,
    opts = {
      keywords = {
        TEST = {
          icon = " ",
          color = "test",
          alt = { "TESTING", "TEST PASSED", "TEST FAILED" },
        },
        NOTE = {
          icon = "󱞁 ",
          color = "hint",
          alt = { "INFO" },
        },
        PERF = { icon = "󱁤 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
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
  { import = "astrocommunity.indent.mini-indentscope" },
  { import = "astrocommunity.color.nvim-highlight-colors" },
  { import = "astrocommunity.lsp.lsplinks-nvim" },
  { import = "astrocommunity.lsp.actions-preview-nvim" },
  { import = "astrocommunity.debugging.nvim-dap-repl-highlights" },
  { import = "astrocommunity.neovim-lua-development.helpview-nvim" },
  { import = "astrocommunity.fuzzy-finder.telescope-zoxide" },
  { import = "astrocommunity.recipes.neovide" },
}
