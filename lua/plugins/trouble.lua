---@type LazySpec
return {
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    cond = not vim.g.vscode,
    opts = {
      keys = {
        ["<ESC>"] = "close",
        ["q"] = "close",
        ["<C-E>"] = "close",
      },
      preview = {
        scratch = false,
      },
      modes = {
        lsp_references = {
          params = {
            include_declaration = false,
          },
        },
      },
    },
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
            function() trouble.toggle { mode = "diagnostics", focus = true, filter = { buf = 0 } } end,
            desc = "Document Diagnostics [T]",
          }
          maps.n[prefix .. "L"] = {
            function() trouble.toggle { mode = "loclist", focus = true } end,
            desc = "Location List [T]",
          }
          maps.n[prefix .. "Q"] = {
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
              callback = function(args)
                if vim.bo[args.buf].filetype == "trouble" then
                  local cursor_pos = vim.api.nvim_win_get_cursor(0)
                  ---@diagnostic disable-next-line: missing-parameter
                  if cursor_pos[1] == 1 and cursor_pos[2] == 0 then vim.schedule(function() trouble.next() end) end
                end
              end,
            },
          }
          opts.autocmds.TroubleMappings = {
            {
              event = "FileType",
              desc = "Create jump mappings for trouble view",
              pattern = "trouble",
              callback = function()
                maps.n["j"] = {
                  ---@diagnostic disable-next-line: missing-parameter
                  function() trouble.next() end,
                  desc = "Jump to next entry",
                }
                maps.n["k"] = {
                  ---@diagnostic disable-next-line: missing-parameter
                  function() trouble.prev() end,
                  desc = "Jump to previous entry",
                }
                require("astrocore").set_mappings(maps, { buffer = 0 })
              end,
            },
          }
        end,
      },
      {
        "nvim-telescope/telescope.nvim",
        opts = function(_, opts)
          local add_to_qf_trouble = function(bufnr) require("trouble.sources.telescope").add(bufnr, { focus = true }) end
          local send_to_qf_trouble = function(bufnr) require("trouble.sources.telescope").open(bufnr, { focus = true }) end

          for _, mode in ipairs { "i", "n" } do
            opts.defaults.mappings[mode] = require("astrocore").extend_tbl(opts.defaults.mappings[mode], {
              ["<C-t>"] = add_to_qf_trouble,
              ["<M-t>"] = send_to_qf_trouble,
            })
          end
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
