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
      local describe_registers = function(mode, prefix)
        local make_register_content = function(register)
          local ok, value = pcall(vim.fn.getreg, register, 1)
          if not ok or value == "" then return nil end
          return vim.inspect(value)
        end

        local all_registers = vim.split('0123456789abcdefghijklmnopqrstuvwxyz*+"-:.%/#', "")
        local register_map = {
          ["0"] = "Latest yank",
          ["1"] = "Latest big delete",
          ['"'] = "Default register",
          ["#"] = "Alternate buffer",
          ["%"] = "Name of the current file",
          ["*"] = "Selection clipboard",
          ["+"] = "System clipboard",
          ["-"] = "Latest small delete",
          ["."] = "Latest inserted text",
          ["/"] = "Latest search pattern",
          [":"] = "Latest executed command",
          ["="] = "Result of expression",
          ["_"] = "Black hole",
        }

        local res = {}
        for _, register in ipairs(all_registers) do
          local register_content = make_register_content(register)
          if register_content then
            local register_desc = register_map[register] and register_map[register] .. ": " or ""
            table.insert(res, {
              mode = mode,
              keys = prefix .. register,
              desc = register_desc .. register_content,
            })
          end
        end
        table.insert(res, { mode = mode, keys = prefix .. "=", desc = "Result of expression" })

        return res
      end
      local registers_with_content = {
        -- Normal mode
        describe_registers("n", '"'),

        -- Visual mode
        describe_registers("x", '"'),

        -- Insert mode
        describe_registers("i", "<C-r>"),

        { mode = "i", keys = "<C-r><C-r>", desc = "+Insert literally" },
        describe_registers("i", "<C-r><C-r>"),

        { mode = "i", keys = "<C-r><C-o>", desc = "+Insert literally + not auto-indent" },
        describe_registers("i", "<C-r><C-o>"),

        { mode = "i", keys = "<C-r><C-p>", desc = "+Insert + fix indent" },
        describe_registers("i", "<C-r><C-p>"),

        -- Command-line mode
        describe_registers("c", "<C-r>"),

        { mode = "c", keys = "<C-r><C-r>", desc = "+Insert literally" },
        describe_registers("c", "<C-r><C-r>"),

        { mode = "c", keys = "<C-r><C-o>", desc = "+Insert literally" },
        describe_registers("c", "<C-r><C-o>"),
      }

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
      for _, trigger in ipairs { "g", "z", "d", "y", "c", "`", "'", '"', "[", "]", "<Leader>" } do
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
        registers_with_content,
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
