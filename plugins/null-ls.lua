local is_available, null_ls = pcall(require, "null-ls")
if not is_available then return {} end

return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    -- local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.diagnostics_format = "#{m} [#{c}] "
    config.sources = {
      -- Set a formatter
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.pyink.with {
        extra_args = {
          "--line-length=79",
        },
      },
      null_ls.builtins.diagnostics.pylint,
      null_ls.builtins.diagnostics.luacheck.with {
        command = "luacheck",
        extra_args = { "-d" },
        filetypes = { "lua" },

        -- force luacheck to find its '.luacheckrc' file
        cwd = function(params)
          -- falls back to root if return value is nil
          return params.root:match(".luacheckrc")
        end,
      },
    }
    vim.api.nvim_create_user_command("NullLsRestart", function()
      require("null-ls.client")._reset()
      vim.cmd.edit()
    end, {})
    return config -- return final config table
  end,
}
