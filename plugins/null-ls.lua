local is_available, null_ls = pcall(require, "null-ls")
local extend_tbl = require("astronvim.utils").extend_tbl
local h = require("null-ls.helpers")
local u = require("null-ls.utils")
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
      null_ls.builtins.formatting.pyink.with {
        extra_args = {
          "--line-length=120",
        },
      },
      null_ls.builtins.diagnostics.pylint,
      null_ls.builtins.diagnostics.mypy,
      null_ls.builtins.formatting.stylua.with {
        args = function(params)
          local args = {
            "--stdin-filepath",
            "$FILENAME",
            "-",
          }
          if u.root_pattern(".stylua.toml")(params.root) then
            table.insert(args, 1, "--config-path")
            table.insert(args, 2, params.root .. "/.stylua.toml")
          elseif not u.root_pattern(".stylua.toml")(params.root) and not u.root_pattern(".editorconfig")(params.root) then
            table.insert(args, 1, "--search-parent-directories")
          end
          return args
        end,
      },
      null_ls.builtins.diagnostics.luacheck.with {
        args = function(params)
          local args = {
            "--formatter",
            "plain",
            "--codes",
            "--ranges",
            "--quiet",
          }
          if u.root_pattern(".luacheckrc")(params.root) then
            table.insert(args, "$ROOT")
          else
            vim.list_extend(args, { "--filename", "$FILENAME", "-" })
          end
          return args
        end,
        generator_opts = extend_tbl(null_ls.builtins.diagnostics.luacheck._opts, { multiple_files = true }),
        on_output = h.diagnostics.from_pattern(
          [[([^:]+):(%d+):(%d+)-(%d+): %((%a)(%d+)%) (.*)]],
          { "filename", "row", "col", "end_col", "severity", "code", "message" },
          {
            severities = {
              E = h.diagnostics.severities["error"],
              W = h.diagnostics.severities["warning"],
            },
            offsets = { end_col = 1 },
          }
        ),
      },
    }
    vim.api.nvim_create_user_command("NullLsRestart", function()
      require("null-ls.client")._reset()
      vim.cmd.edit()
    end, {})
    return config -- return final config table
  end,
}
