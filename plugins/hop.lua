return {
    "RayJameson/hop.nvim",
    opts = {
      case_insensitive = false,
    },
    keys = function()
      local hop = require("hop")
      local directions = require("hop.hint").HintDirection
      return {
        {
          "f",
          function() hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true } end,
          desc = "Move to the next char",
        },
        {
          "F",
          function() hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true } end,
          desc = "Move to the previous char",
        },
        {
          "t",
          function() hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 } end,
          desc = "Move before next char",
        },
        {
          "T",
          function() hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 } end,
          desc = "Move after previous char",
        },
      }
    end,
  }
