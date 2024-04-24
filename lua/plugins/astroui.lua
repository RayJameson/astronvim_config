local C = require("colors")
---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "astrodark",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = function() -- a table of overrides/changes when applying the astrotheme theme
        local hl = {
          CursorLineNr = { fg = C.blue_1 },
          FoldColumn = { fg = C.grey_9, bg = C.none },
          LineNrAbove = { fg = C.pale_red },
          LineNrBelow = { fg = C.pale_green },
          DiagnosticVirtualTextHint = { fg = C.white, bg = C.none },
          DiagnosticVirtualTextWarn = { fg = C.equator, bg = C.none },
          DiagnosticVirtualTextInfo = { fg = C.wild_willow, bg = C.none },
          QuickFixLine = { fg = C.white },
          NeoTreeTabActive = { fg = C.fg, bold = true, italic = true },
          Keyword = { fg = C.purple, italic = true },
          Define = { fg = C.purple, italic = true },
          Include = { fg = C.purple, italic = true },
          Statement = { fg = C.purple, bg = C.none, italic = true }, -- any statement,
          Conditional = { fg = C.purple, bg = C.none, italic = true }, -- if, then, else, endif, switch, etc.,
          Repeat = { fg = C.purple, bg = C.none, italic = true }, -- for, do, while, etc.,
          Label = { fg = C.blue, bg = C.none, italic = true }, -- case, default, etc.,
          Exception = { fg = C.purple, bg = C.none, italic = true }, -- try, catch, throw,
          Boolean = { fg = C.bright_turquoise, bg = C.none }, -- a boolean constant: TRUE, false,
          DiffDelete = { fg = C.bg, bg = C.red_1 },
          NormalFloat = { bg = C.bg },
          TabLine = { bg = C.bg },
          MatchParen = { fg = C.bright_turquoise, bg = C.none, bold = true },
          DiagnosticFloatingOk = { link = "DiagnosticOk" },
          DiagnosticFloatingError = { link = "DiagnosticError" },
          DiagnosticFloatingWarn = { link = "DiagnosticWarn" },
          DiagnosticFloatingInfo = { link = "DiagnosticInfo" },
          DiagnosticFloatingHint = { link = "DiagnosticHint" },
          FloatShadow = { bg = C.bg },
          FloatShadowThrough = { bg = C.bg },
          TreesitterContextLineNumber = { fg = C.pale_red, bg = C.bg },
          TelescopeSelection = { fg = C.fg, bg = C.surface1 },
          IlluminatedWordText = { fg = C.none, bg = C.surface1 },
          IlluminatedWordRead = { fg = C.none, bg = C.surface1 },
          IlluminatedWordWrite = { fg = C.none, bg = C.surface1 },
          Type = { fg = C.cyan },
          ["@lsp.typemod.function.global"] = { fg = C.blue_1 },
          ["@method"] = { fg = C.cyan, bg = C.none },
          ["@function.method.call.lua"] = { link = "@method" },
          ["@lsp.type.class"] = { fg = C.blue },
          ["@lsp.type.namespace.python"] = { link = "Identifier" },
          ["@function.builtin"] = { fg = C.blue_1 },
          ["@variable.builtin"] = { fg = C.red_3 },
        }
        if require("astrocore").is_available("mini.clue") then
          hl.MiniClueDescGroup = { fg = C.purple }
          hl.MiniClueDescSingle = { fg = C.blue }
          hl.MiniClueNextKey = { fg = C.blue }
          hl.MiniClueSeparator = { fg = C.grey_1 }
        end
        return hl
      end,
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",

      ActiveLSP = "",
      ActiveTS = " ",
      BufferClose = "",
      DapBreakpoint = "",
      DapBreakpointCondition = "",
      DapBreakpointRejected = "",
      DapLogPoint = "",
      DapStopped = "",
      DefaultFile = "",
      Diagnostic = "",
      DiagnosticError = "",
      DiagnosticHint = "",
      DiagnosticInfo = "",
      DiagnosticWarn = "",
      Ellipsis = "",
      FileModified = "",
      FileReadOnly = "",
      FoldClosed = "",
      FoldOpened = "",
      FolderClosed = "",
      FolderEmpty = "",
      FolderOpen = "",
      Git = "",
      GitAdd = "",
      GitBranch = "",
      GitChange = "",
      GitConflict = "",
      GitDelete = "",
      GitIgnored = "",
      GitRenamed = "",
      GitStaged = "",
      GitUnstaged = "",
      GitUntracked = "",
      LSPLoaded = "",
      MacroRecording = "",
      Paste = "",
      Search = "",
      Selected = "",
      TabClose = "",
    },
    status = {
      separators = {
        breadcrumbs = "  ",
        path = "  ",
      },
    },
  },
}
