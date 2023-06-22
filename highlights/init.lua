return function(hl) -- or a function that returns a new table of colors to set
  local C = require("user.highlights.colors")
  hl.TelescopeResultsVariable = { fg = C.fg }
  hl.CursorLineNr = { fg = C.blue_1 }
  hl.LineNrAbove = { fg = C.red_1 }
  hl.LineNrBelow = { fg = C.toml }
  hl.LspInlayHint = { link = "Comment" }
  hl.Visual = { fg = C.none, bg = C.grey_5, reverse = true } -- invert visual selection
  -- hl["@variable"] = { fg = C.fg }
  hl["@float"] = { fg = C.orange }
  hl["@attribute"] = { fg = C.gold }
  hl["@boolean"] = { fg = "#1BF9C4" }
  hl["@type.builtin"] = { fg = C.blue_1 }
  hl["@conditional"] = { fg = C.purple, italic = true }
  hl["@repeat"] = { fg = C.purple, italic = true }
  hl["@exception"] = { fg = C.purple, italic = true }
  hl["@keyword.function"] = { fg = C.purple, italic = true }
  hl["@keyword.operator"] = { fg = C.purple, italic = true }
  hl["@function.builtin"] = { fg = C.blue_1 }
  hl["@class_variable"] = { fg = C.red }
  hl["@method"] = { fg = "#61afef" }
  hl["@lsp.typemod.function.global"] = { fg = C.blue }
  hl["@punctuation.special.markdown"] = { fg = C.fg }
  hl["@lsp.typemod.function.defaultLibrary"] = { fg = C.blue_1 }
  hl.Keyword = { fg = C.purple, italic = true }
  hl.Define = { fg = C.purple, italic = true }
  hl.Include = { fg = C.purple, italic = true }
  hl.DapUIVariable = { fg = C.fg }
  hl.DiagnosticVirtualTextHint = { fg = "#E0E1E4", bg = "none" }
  hl.DiagnosticVirtualTextWarn = { fg = "#e0af68", bg = "none" }
  hl.DiagnosticVirtualTextInfo = { fg = "#9ece6a", bg = "none" }
  hl.NeoTreeTabActive = { fg = C.fg, bold = true, italic = true }
  hl.QuickFixLine = { fg = C.white }
  hl.BqfPreviewFloat = { fg = C.fg, bg = C.bg }
  if vim.g.transparent_enabled then
    hl.TreesitterContextLineNumber = { fg = C.red_1 }
    hl.Normal = { fg = C.fg }
  else
    hl.TreesitterContextLineNumber = { fg = C.red_1, bg = C.bg }
  end
  return hl
end
