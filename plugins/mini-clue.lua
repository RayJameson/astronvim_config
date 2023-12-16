return {
  { "folke/which-key.nvim", enabled = false },
  {
    "echasnovski/mini.clue",
    event = "VeryLazy",
    cond = not vim.g.vscode,
    opts = function(_, opts)
      local miniclue = require("mini.clue")
      local astronvim_clues = {}
      for mode, maps in pairs(require("astronvim.utils").which_key_queue) do
        for keys, map in pairs(maps) do
          if type(map) == "table" then
            local desc = map.name or map.desc
            if desc then table.insert(astronvim_clues, { mode = mode, keys = keys, desc = desc }) end
          end
        end
      end

      opts.triggers = {
        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- Registers
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },
      }
      local triggers_prepare = {}
      for _, trigger in ipairs { "g", "z", "m", "`", "'", '"', "[", "]", "<Leader>" } do
        for _, mode in ipairs { "n", "x" } do
          table.insert(triggers_prepare, { mode = mode, keys = trigger })
        end
      end
      vim.list_extend(opts.triggers, triggers_prepare)
      opts.window = {
        delay = 0,
        config = {
          anchor = "SW", -- bottom-left,
          row = "auto",
          col = "auto",
          width = "auto",
        },
      }
      opts.clues = {
        astronvim_clues,
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
      }
      return opts
    end,
  },
}
