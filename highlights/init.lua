return function(hl) -- or a function that returns a new table of colors to set
  local C = require("user.highlights.colors")
  hl.TelescopeResultsVariable = { fg = C.fg }
  hl.CursorLineNr = { fg = C.blue_1 }
  hl.LineNrAbove = { fg = C.red_1 }
  hl.LineNrBelow = { fg = C.toml }
  hl.Visual = { fg = C.none, bg = C.grey_5, reverse = true } -- invert visual selection
  hl["@variable"] = { fg = C.fg }
  hl["@float"] = { fg = C.orange }
  hl["@attribute"] = { fg = C.gold }
  hl["@boolean"] = { fg = "#1BF9C4" }
  hl["@type.builtin"] = { fg = C.blue_1 }
  hl["@keyword"] = { fg = C.purple, italic = true }
  hl["@conditional"] = { fg = C.purple, italic = true }
  hl["@repeat"] = { fg = C.purple, italic = true }
  hl["@exception"] = { fg = C.purple, italic = true }
  hl["@keyword.function"] = { fg = C.purple, italic = true }
  hl["@keyword.operator"] = { fg = C.purple, italic = true }
  hl["@function.builtin"] = { fg = C.blue_1 }
  hl["@class_variable"] = { fg = C.red }
  hl.Normal = { fg = C.fg, bg = C.bg }
  hl.Folded = { bg = "#3c4855" }
  -- Normal
  -- hl.NormalFloat = { bg = "none" }
  hl.NormalNC = { bg = "none" }
  hl.FloatBorder = { bg = "none" }
  -- WinBar
  hl.WinBar = { bg = "none" }
  hl.WinBarNC = { bg = "none" }
  -- hl.WhichKeyFloat = { bg = "none" }
  -- Telescope
  hl.TelescopeBorder = { bg = "none" }
  hl.TelescopeNormal = { bg = "none" }
  -- Diagnosis
  hl.DiagnosticVirtualTextHint = { fg = "#E0E1E4", bg = "none" }
  hl.DiagnosticVirtualTextWarn = { fg = "#e0af68", bg = "none" }
  hl.DiagnosticVirtualTextInfo = { fg = "#9ece6a", bg = "none" }
  -- hl.DiagnosticVirtualTextError = { fg = "#c53b53", bg = "none" }
  -- NeoTree
  hl.NeoTreeNormal = { bg = "none" }
  hl.NeoTreeNormalNC = { bg = "none" }
  -- StatusLine
  -- hl.StatusLine = { bg = "none" }
  -- hl.StatusLineNC = { bg = "none" }
  -- hl.StatusLineTerm = { bg = "none" }
  -- hl.StatusLineTermNC = { bg = "none" }
  -- QuickFixLine
  hl.QuickFixLine = { bg = "none" }
  -- TabLine
  -- hl.TabLine = { bg = "none" }
  -- hl.TabLineSel = { bg = "none" }
  -- hl.TabLineFill = { bg = "none" }
  -- Cursor
  -- hl.CursorLineNr = { bg = "none" }
  -- hl.CursorLine = { bg = "none" }
  -- hl.ColorColumn = { bg = "none" }
  -- Search
  hl.Search = { fg = "red" }
  hl.IncSearch = { fg = "red" }
  -- Pmenu
  hl.Pmenu = { bg = "none" }
  hl.PmenuSel = { bg = "none" }
  hl.PmenuSbar = { bg = "none" }
  hl.PmenuThumb = { bg = "none" }
  hl.NotifyINFOBody = { bg = "NONE" }
  hl.NotifyWARNBody = { bg = "NONE" }
  hl.NotifyERRORBody = { bg = "NONE" }
  hl.NotifyDEBUGBody = { bg = "NONE" }
  hl.NotifyTRACEBody = { bg = "NONE" }
  hl.NotifyINFOBorder = { bg = "NONE" }
  hl.NotifyWARNBorder = { bg = "NONE" }
  hl.NotifyERRORBorder = { bg = "NONE" }
  hl.NotifyDEBUGBorder = { bg = "NONE" }
  hl.NotifyTRACEBorder = { bg = "NONE" }
  hl.NotifyBackground = { bg = "#000000" }
  -- Notify
  -- require("notify").setup {
  --   background_colour = "#000000",
  -- },
  -- hl.FoldColumn = { bg = "#25BE83" }

  vim.cmd("hi! TreesitterContextLineNumber guifg=#c678dd")

  return hl
end
