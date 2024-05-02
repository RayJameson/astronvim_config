local C = require("colors")
---@type LazySpec
return {
  "AstroNvim/astrotheme",
  ---@type AstroThemeOpts
  opts = {
    palettes = {
      astrodark = {
        ui = {
          base = C.bg,
          statusline = C.bg_1,
          green = C.green_1,
          inactive_base = C.surface0,
          float = C.bg,
          tabline = C.bg,
          none_text = C.subtext0,
          split = C.border,
          cyan = C.blue,
        },
        syntax = {
          red = C.red,
          blue = C.blue,
          green = C.green,
          orange = C.orange,
          cyan = C.cyan,
          purple = C.purple,
          yellow = C.yellow,
          comment = C.subtext1,
        },
      },
    },
    highlights = {
      astrodark = {
        ColorColumn = { fg = C.none, bg = C.bg_1 },
        BufferLineTab = { fg = C.fg, bg = C.none },
      },
    },
  },
}
