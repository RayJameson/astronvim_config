local is_available = require("astronvim.utils").is_available
return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  init = function()
    vim.api.nvim_create_autocmd({ "FileType" }, {
      pattern = "norg",
      group = vim.api.nvim_create_augroup("NeorgConceal", { clear = true }),
      callback = function()
        vim.wo.conceallevel = 2
        vim.wo.concealcursor = "ncv"
      end,
    })
  end,
  opts = function()
    local presenter = (
      is_available("zen-mode.nvim")
        and {
          config = {
            zen_mode = "zen-mode",
          },
        }
      or is_available("true-zen.nvim")
        and {
          config = {
            zen_mode = "true-zen",
          },
        }
    ) or nil
    return {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.integrations.treesitter"] = {}, -- Loads default behaviour
        ["core.concealer"] = {
          config = {
            icon_preset = "varied",
          },
        }, -- Adds pretty icons to your documents
        ["core.keybinds"] = {}, -- Adds default keybindings
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        }, -- Enables support for completion plugins
        ["core.journal"] = {}, -- Enables support for the journal module
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              root = vim.env.HOME .. "/neorg",
            },
            default_workspace = "root",
          },
        },
        ["core.autocommands"] = {},
        ["core.queries.native"] = {},
        ["core.presenter"] = presenter,
        ["core.esupports.metagen"] = {},
        ["core.esupports.hop"] = {},
        ["core.esupports.indent"] = {},
        ["core.qol.todo_items"] = {},
        ["core.qol.toc"] = {},
        ["core.export"] = {},
        ["core.export.markdown"] = {
          config = {
            extensions = "all",
          },
        },
        ["core.upgrade"] = {},
        ["core.promo"] = {},
        ["core.summary"] = {},
        ["core.ui.calendar"] = {},
      },
    }
  end,
}
