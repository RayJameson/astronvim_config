return function(hl) -- or a function that returns a new table of colors to set
  local C = require("user.highlights.colors")
  if not vim.g.vscode then
    hl.CursorLineNr = { fg = C.blue_1 }
    hl.LineNrAbove = { fg = C.pale_red }
    hl.LineNrBelow = { fg = C.pale_green }
    hl.DiagnosticVirtualTextHint = { fg = C.white, bg = "none" }
    hl.DiagnosticVirtualTextWarn = { fg = C.equator, bg = "none" }
    hl.DiagnosticVirtualTextInfo = { fg = C.wild_willow, bg = "none" }
    hl.QuickFixLine = { fg = C.white }
    hl.NeoTreeTabActive = { fg = C.fg, bold = true, italic = true }
    hl.Keyword = { fg = C.purple, italic = true }
    hl.Define = { fg = C.purple, italic = true }
    hl.Include = { fg = C.purple, italic = true }
    hl.Statement = { fg = C.purple, bg = C.none, italic = true } -- any statement
    hl.Conditional = { fg = C.purple, bg = C.none, italic = true } -- if, then, else, endif, switch, etc.
    hl.Repeat = { fg = C.purple, bg = C.none, italic = true } -- for, do, while, etc.
    hl.Label = { fg = C.blue, bg = C.none, italic = true } -- case, default, etc.
    hl.Exception = { fg = C.purple, bg = C.none, italic = true } -- try, catch, throw
    hl.Boolean = { fg = C.bright_turquoise, bg = C.none } -- a boolean constant: TRUE, false
    hl.DiffDelete = { fg = C.red }
    hl["@lsp.typemod.function.global"] = { fg = C.blue_1 }
    hl["@function.builtin"] = { fg = C.blue_1 }
    hl["@variable.builtin"] = { fg = C.red_3 }
  end
  if vim.g.transparent_enabled then
    hl.TreesitterContextLineNumber = { fg = C.pale_red }
    hl.Normal = { fg = C.fg }
  else
    hl.TreesitterContextLineNumber = { fg = C.pale_red, bg = C.bg }
  end
  return hl
end
