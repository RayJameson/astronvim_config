return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  -- { import = "astrocommunity.colorscheme.catppuccin" },
  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
  { import = "astrocommunity.bars-and-lines.heirline-vscode-winbar" },
  { import = "astrocommunity.bars-and-lines.heirline-mode-text-statusline" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.utility.neodim" },
  { import = "astrocommunity.utility.transparent-nvim" },
  {
    "transparent.nvim",
    priority = 1000,
    opts = {
      extra_groups = { -- table/string: additional groups that should be cleared
        -- In particular, when you set it to 'all', that means all available groups
        "BqfPreviewFloat",
        "NormalFloat",
        "NormalNC",
        "NvimTreeNormal",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NeoTreePreview",
        "NeoTreeTabInactive",
        "CursorLine",
        "CursorLineNr",
        "FloatBorder",
        "WinBar",
        "WinBarNC",
        "TreesitterContext",
        "Pmenu",
        "DapUIPlayPause",
        "DapUIRestart",
        "DapUIStop",
        "DapUIStepOut",
        "DapUIStepBack",
        "DapUIStepInto",
        "DapUIStepOver",
        "DapUIPlayPauseNC",
        "DapUIRestartNC",
        "DapUIStopNC",
        "DapUIStepOutNC",
        "DapUIStepBackNC",
        "DapUIStepIntoNC",
        "DapUIStepOverNC",
        "TelescopeBorder",
        "TelescopeNormal",
        "TelescopePreviewNormal",
        "TelescopeResultsNormal",
        "TelescopePromptNormal",
        "TabLineFill",
        "TreesitterContextLineNumber",
        "QuickFixLine",
        "Pmenu",
        "PmenuSel",
        "PmenuSbar",
        "PmenuThumb",
        "NotifyINFOBody",
        "NotifyWARNBody",
        "NotifyERRORBody",
        "NotifyDEBUGBody",
        "NotifyTRACEBody",
        "NotifyINFOBorder",
        "NotifyWARNBorder",
        "NotifyERRORBorder",
        "NotifyDEBUGBorder",
        "NotifyTRACEBorder",
      },
    },
  },
  { import = "astrocommunity.markdown-and-latex.glow-nvim" },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  { import = "astrocommunity.editing-support.nvim-ts-rainbow2" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  {
    "todo-comments.nvim",
    opts = {
      keywords = {
        TEST = {
          icon = " ",
          color = "test",
          alt = { "TESTING", "PASSED", "FAILED" },
        },
      },
    },
  },
  { import = "astrocommunity.editing-support.neogen" },
  {
    "neogen",
    opts = {
      languages = {
        python = { template = { annotation_convention = "reST" } },
        rust = { template = { annotation_convention = "rustdoc" } },
        sh = { template = { annotation_convention = "google_bash" } },
      },
    },
  },
  { import = "astrocommunity.editing-support.nvim-regexplainer" },
  {
    "nvim-regexplainer",
    ft = {
      "html",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "python",
      "rust",
    },
  },
  { import = "astrocommunity.project.nvim-spectre" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.vim-matchup" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
}
