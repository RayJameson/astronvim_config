return function(hl) -- or a function that returns a new table of colors to set
  local C = require("highlights.colors")
  hl["@variable"] = { fg = C.fg }
  hl["@attribute"] = { fg = C.gold }
  hl["@keyword"] = { fg = C.purple, italic = true }
  hl["@conditional"] = { fg = C.purple, italic = true }
  hl["@repeat"] = { fg = C.purple, italic = true }
  hl["@exception"] = { fg = C.purple, italic = true }
  hl["@keyword.function"] = { fg = C.purple, italic = true }
  hl["@keyword.operator"] = { fg = C.purple, italic = true }
  hl["@function.builtin"] = { fg = C.blue_1 }
  hl["@lsp.typemod.function.global"] = { fg = C.blue }
  hl["@lsp.typemod.function.defaultLibrary"] = { fg = C.blue_1 }
  hl["@class_variable"] = { fg = C.red }
  hl["@method"] = { fg = "#61afef" }
  hl.Normal = { fg = C.fg, bg = C.bg }
  return hl
end
