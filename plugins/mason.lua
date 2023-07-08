local list_insert_unique = require("astronvim.utils").list_insert_unique
-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = list_insert_unique(opts.ensure_installed, {
        "lua_ls",
        "ruff_lsp",
        "pyright",
        "jedi_language_server",
      })
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = list_insert_unique(opts.ensure_installed, {
        -- "prettier",
        "stylua",
        "pyink",
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    ft = { "python", "go", "rust", "javascript" },
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = list_insert_unique(opts.ensure_installed, {
        -- "python",
      })
      opts.handlers = {
        python = function(config)
          config.configurations = {
            {
              type = "python",
              request = "launch",
              name = "Python: Debug Current File",
              program = "${file}",
              justMyCode = false,
              console = "integratedTerminal",
              pythonPath = function()
                return "python"
              end,
            },
            {
              type = "python",
              request = "launch",
              name = "Python: Debug FastAPI web application",
              module = "uvicorn",
              args = {
                "main:app",
                "--use-colors",
              },
              pythonPath = function()
                return "python"
              end,
              console = "integratedTerminal",
            },
          }
          require("mason-nvim-dap").default_setup(config) -- don't forget this!
        end,
      }
    end,
  },
}
