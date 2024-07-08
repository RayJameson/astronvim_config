local utils = require("astrocore")
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "scala" })
      end
    end,
  },
  {
    "scalameta/nvim-metals",
    enabled = function() return vim.fn.executable("cs") == 1 or vim.fn.executable("coursier") == 1 end,
    ft = { "scala", "sbt", "java" },
    specs = {
      { "AstroNvim/astrolsp", opts = { handlers = { metals = false } } },
      {
        "mfussenegger/nvim-dap",
        optional = true,
        config = function()
          require("dap").configurations.scala = {
            {
              type = "scala",
              request = "launch",
              name = "RunOrTest",
              metals = { runType = "runOrTestFile" },
            },
            {
              type = "scala",
              request = "launch",
              name = "Test Target",
              metals = { runType = "testTarget" },
            },
          }
        end,
      },
    },
    opts = function()
      local metals = require("metals")
      local user_config = require("astrolsp").lsp_opts("metals")
      if require("astrocore").is_available("nvim-dap") then
        local on_attach = user_config.on_attach
        user_config.on_attach = function(...)
          on_attach(...)
          metals.setup_dap()
        end
      end
      return require("astrocore").extend_tbl(metals.bare_config(), user_config)
    end,
  },
  config = function(self, opts)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = self.ft,
      group = vim.api.nvim_create_augroup("nvim-metals", { clear = true }),
      desc = "Initialize and attach nvim-metals",
      callback = function() require("metals").initialize_or_attach(opts) end,
    })
  end,
}
