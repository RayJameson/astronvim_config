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
  { import = "astrocommunity.pack.go" },
  {
    "ray-x/go.nvim",
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
  { import = "astrocommunity.utility.neodim" },
  { import = "astrocommunity.file-explorer.mini-files" },
  {
    "mini.files",
    opts = {
      windows = {
        preview = true,
        width_preview = 80,
      },
      mappings = {
        go_in_plus = "<CR>",
        go_in = "L",
        go_out = "H",
        go_out_plus = "",
      },
    },
  },
  { import = "astrocommunity.utility.transparent-nvim" },
  {
    "transparent.nvim",
    cond = not vim.g.neovide,
    priority = 1000,
    opts = {
      extra_groups = { -- table/string: additional groups that should be cleared
        -- In particular, when you set it to 'all', that means all available groups
        "BqfPreviewFloat",
        "NormalFloat",
        "NvimTreeNormal",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NeoTreePreview",
        "NeoTreeTabInactive",
        "CursorLine",
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
        "WhichKeyFloat",
      },
    },
  },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  {
    "todo-comments.nvim",
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
  { import = "astrocommunity.project.nvim-spectre" },
  { import = "astrocommunity.motion.vim-matchup" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  {
    "trouble.nvim",
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
          require("astronvim.utils").set_mappings(maps, { buffer = 0 })
        end,
        group = vim.api.nvim_create_augroup("TroubleMappings", { clear = true }),
      })
    end,
  },
  { import = "astrocommunity.code-runner.sniprun" },
}
