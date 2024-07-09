---@type LazySpec
return {
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    cond = not vim.g.vscode,
    opts = function()
      local get_icon = require("astroui").get_icon
      local lspkind_avail, lspkind = pcall(require, "lspkind")
      return {
        keys = {
          ["<ESC>"] = "close",
          ["q"] = "close",
          ["<C-E>"] = "close",
        },
        icons = {
          indent = {
            fold_open = get_icon("FoldOpened"),
            fold_closed = get_icon("FoldClosed"),
          },
          folder_closed = get_icon("FolderClosed"),
          folder_open = get_icon("FolderOpen"),
          kinds = lspkind_avail and lspkind.symbol_map,
        },
        include_declaration = { "lsp_definitions" },
        auto_jump = { "lsp_definitions", "lsp_references", "lsp_implementations" },
        action_keys = {
          jump_close = { "o", "<CR>" },
          jump = { "<tab>", "<2-leftmouse>" },
        },
      }
    end,
    specs = {
      { "AstroNvim/astroui", opts = { icons = { Trouble = "󱍼" } } },
      {
        "AstroNvim/astrolsp",
        opts = function(
          _,
          opts --[[@as AstroLSPOpts]]
        )
          local maps = opts.mappings
          local trouble = require("trouble")
          maps.n.gr = {
            function() trouble.toggle { mode = "lsp_references", focus = true, auto_jump = true } end,
            desc = "LSP references [T]",
          }
          maps.n["<Leader>lR"] = {
            function() trouble.toggle { mode = "lsp_references", focus = true, auto_jump = true } end,
            desc = "LSP references [T]",
          }
          maps.n.gd = {
            function() trouble.toggle { mode = "lsp_definitions", focus = true, auto_jump = true } end,
            desc = "LSP definitions [T]",
          }
          maps.n.gI = {
            function() trouble.toggle { mode = "lsp_implementations", focus = true, auto_jump = true } end,
            desc = "LSP implementations [T]",
          }
        end,
      },
      {
        "AstroNvim/astrocore",
        opts = function(
          _,
          opts --[[@as AstroCoreOpts]]
        )
          local maps = opts.mappings
          local prefix = "<Leader>x"
          local trouble = require("trouble")
          maps.n[prefix] = { desc = require("astroui").get_icon("Trouble", 1, true) .. "Trouble" }
          maps.n[prefix .. "X"] = {
            function() trouble.toggle { mode = "diagnostics", focus = true } end,
            desc = "Workspace Diagnostics [T]",
          }
          maps.n[prefix .. "x"] = {
            function() trouble.toggle { mode = "diagnostics", focus = true, filter = { bufnr = 0 } } end,
            desc = "Document Diagnostics [T]",
          }
          maps.n[prefix .. "l"] = {
            function() trouble.toggle { mode = "loclist", focus = true } end,
            desc = "Location List [T]",
          }
          maps.n[prefix .. "q"] = {
            function() trouble.toggle { mode = "quickfix", focus = true } end,
            desc = "Quickfix List [T]",
          }
          if require("astrocore").is_available("todo-comments.nvim") then
            maps.n[prefix .. "t"] = {
              function() trouble.toggle { mode = "todo", focus = true } end,
              desc = "Todo [T]",
            }
            maps.n[prefix .. "T"] = {
              function() trouble.toggle { mode = "todo", focus = true, filter = { tag = { "TODO", "FIXME", "FIX" } } } end,
              desc = "Todo/Fix/Fixme [T]",
            }
          end
          opts.autocmds.TroubleView = {
            {
              event = "BufEnter",
              desc = "Jump to first entry in trouble view",
              pattern = "trouble",
              once = true,
              callback = function()
                local cursor_pos = vim.api.nvim_win_get_cursor(0)
                if cursor_pos[1] == 1 and cursor_pos[2] == 0 then vim.api.nvim_feedkeys("jj", "n", false) end
              end,
            },
          }
          opts.autocmds.TroubleMappings = {
            {
              event = "FileType",
              desc = "Create jump mappings for trouble view",
              pattern = "trouble",
              callback = function()
                local next = require("trouble").next
                local previous = require("trouble").prev
                maps.n["<M-j>"] = {
                  function() next {} end,
                  desc = "Jump to next entry",
                }
                maps.n["<M-k>"] = {
                  function() previous {} end,
                  desc = "Jump to previous entry",
                }
                maps.n["j"] = {
                  function() next { skip_groups = true } end,
                  desc = "Jump to next entry",
                }
                maps.n["k"] = {
                  function() previous { skip_groups = true } end,
                  desc = "Jump to previous entry",
                }
                require("astrocore").set_mappings(maps, { buffer = 0 })
              end,
            },
          }
        end,
      },
      { "lewis6991/gitsigns.nvim", opts = { trouble = true } },
      {
        "folke/edgy.nvim",
        optional = true,
        opts = function(_, opts)
          if not opts.bottom then opts.bottom = {} end
          table.insert(opts.bottom, "Trouble")
        end,
      },
      {
        "catppuccin",
        optional = true,
        ---@type CatppuccinOptions
        opts = { integrations = { lsp_trouble = true } },
      },
    },
  },
}
