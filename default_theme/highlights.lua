return function(hl) -- or a function that returns a new table of colors to set
    local C = require("default_theme.colors")
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
    -- hl.FoldColumn = { bg = "#25BE83" }

    -- New approach instead of diagnostic_style
    hl.DiagnosticError.italic = true
    hl.DiagnosticHint.italic = true
    hl.DiagnosticInfo.italic = true
    hl.DiagnosticWarn.italic = true
    vim.cmd("hi! TreesitterContextLineNumber guifg=#c678dd")

    return hl
end
