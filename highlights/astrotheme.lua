if vim.g.vscode then return {} end
local is_available = require("astronvim.utils").is_available
return function(hl) -- or a function that returns a new table of colors to set
  local C = require("user.highlights.colors")
  hl.CursorLineNr = { fg = C.blue_1 }
  hl.FoldColumn = { fg = C.grey_9, bg = C.none }
  hl.LineNrAbove = { fg = C.pale_red }
  hl.LineNrBelow = { fg = C.pale_green }
  hl.DiagnosticVirtualTextHint = { fg = C.white, bg = C.none }
  hl.DiagnosticVirtualTextWarn = { fg = C.equator, bg = C.none }
  hl.DiagnosticVirtualTextInfo = { fg = C.wild_willow, bg = C.none }
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
  hl.DiffDelete = { fg = C.bg, bg = C.red_1 }
  hl.NormalFloat = { bg = C.bg }
  hl.TabLine = { bg = C.bg }
  hl.DiagnosticFloatingOk = { link = "DiagnosticOk" }
  hl.DiagnosticFloatingError = { link = "DiagnosticError" }
  hl.DiagnosticFloatingWarn = { link = "DiagnosticWarn" }
  hl.DiagnosticFloatingInfo = { link = "DiagnosticInfo" }
  hl.DiagnosticFloatingHint = { link = "DiagnosticHint" }
  hl.FloatShadow = { bg = C.bg }
  hl.FloatShadowThrough = { bg = C.bg }
  hl["@lsp.typemod.function.global"] = { fg = C.blue_1 }
  hl["@function.builtin"] = { fg = C.blue_1 }
  hl["@variable.builtin"] = { fg = C.red_3 }
  if is_available("mini.clue") then
    hl.MiniClueDescGroup = { fg = C.purple }
    hl.MiniClueDescSingle = { fg = C.blue }
    hl.MiniClueNextKey = { fg = C.blue }
    hl.MiniClueSeparator = { fg = C.grey_1 }
  end
  if vim.g.transparent_enabled then
    hl.TreesitterContextLineNumber = { fg = C.pale_red }
    hl.Normal = { fg = C.fg }
  else
    hl.TreesitterContextLineNumber = { fg = C.pale_red, bg = C.bg }
  end
  return hl
end
