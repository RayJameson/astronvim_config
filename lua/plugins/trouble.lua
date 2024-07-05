---@type LazySpec
return {
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    cond = not vim.g.vscode,
    dependencies = {
      { "AstroNvim/astroui", opts = { icons = { Trouble = "󱍼" } } },
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          local prefix = "<Leader>x"
          maps.n[prefix] = { desc = require("astroui").get_icon("Trouble", 1, true) .. "Trouble" }
          maps.n[prefix .. "X"] =
            { "<Cmd>Trouble diagnostics toggle focus=true<CR>", desc = "Workspace Diagnostics (Trouble)" }
          maps.n[prefix .. "x"] =
            { "<Cmd>Trouble diagnostics toggle filter.buf=0 focus=true<CR>", desc = "Document Diagnostics (Trouble)" }
          maps.n[prefix .. "l"] = { "<Cmd>Trouble loclist toggle focus=true<CR>", desc = "Location List (Trouble)" }
          maps.n[prefix .. "q"] = { "<Cmd>Trouble quickfix toggle focus=true<CR>", desc = "Quickfix List (Trouble)" }
          if require("astrocore").is_available("todo-comments.nvim") then
            maps.n[prefix .. "t"] = {
              "<cmd>Trouble todo focus=true<cr>",
              desc = "Todo (Trouble)",
            }
            maps.n[prefix .. "T"] = {
              "<cmd>Trouble todo filter={tag={TODO,FIX,FIXME}} focus=true<cr>",
              desc = "Todo/Fix/Fixme (Trouble)",
            }
          end
        end,
      },
    },
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
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "trouble",
        callback = function()
          local next = require("trouble").next
          local previous = require("trouble").prev
          local maps = { n = {} }
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
        group = vim.api.nvim_create_augroup("TroubleMappings", { clear = true }),
      })
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
}
