local prefix = "<Leader>u"
---@type LazySpec
return {
  "xiyaowong/transparent.nvim",
  lazy = false,
  opts = {
    -- table: default groups
    groups = {
      "Normal",
      "NormalNC",
      "Comment",
      "Constant",
      "Special",
      "Identifier",
      "Statement",
      "PreProc",
      "Type",
      "Underlined",
      "Todo",
      "String",
      "Function",
      "Conditional",
      "Repeat",
      "Operator",
      "Structure",
      "LineNr",
      "NonText",
      "SignColumn",
      "CursorLineNr",
      "CursorLine",
      "EndOfBuffer",
    },
    -- table: additional groups that should be cleared
    extra_groups = {
      "NormalFloat",
      "NvimTreeNormal",
      "NeoTreeNormal",
      "NeoTreeFloatBorder",
      "NeoTreeNormalNC",
      "TelescopeNormal",
      "TelescopePromptNormal",
      "TelescopePreviewNormal",
      "TelescopeResultsNormal",
      "TelescopePreviewBorder",
      "TelescopePromptBorder",
      "TelescopeResultsBorder",
      "TelescopeResultsTitle",
      "TelescopePromptTitle",
      "TelescopePreviewTitle",
      "WinBar",
      "WinSeparator",
      "VertSplit",
      "WinBarNC",
      "FloatBorder",
      "FloatTitle",
      "BufferLineTab",
      "TabLineFill",
      "TabLineSel",
      "Title",
      "Pmenu",
      "PmenuSel",
      "PmenuSbar",
      "TabLine",
      "TreesitterContextLineNumber",
      "NotifyERRORBorder",
      "NotifyWARNBorder",
      "NotifyINFOBorder",
      "NotifyDEBUGBorder",
      "NotifyTRACERBorder",
      "NotifyERRORIcon",
      "NotifyWARNIcon",
      "NotifyINFOIcon",
      "NotifyDEBUGIcon",
      "NotifyTRACEIcon",
      "NotifyERRORTitle",
      "NotifyWARNTitle",
      "NotifyINFOTitle",
      "NotifyDEBUGTitle",
      "NotifyTRACETitle",
      "NotifyERRORBody",
      "NotifyWARNBody",
      "NotifyINFOBody",
      "NotifyDEBUGBody",
      "NotifyTRACEBody",
      "NotifyLogTime",
      "NotifyLogTitle",
    },
    -- table: groups you don't want to clear
    exclude_groups = {},
  },
  keys = {
    { prefix .. "T", "<cmd>TransparentToggle<CR>", desc = "Toggle transparency" },
  },
}
