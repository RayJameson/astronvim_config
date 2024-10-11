---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "gbprod/none-ls-luacheck.nvim",
  },
  opts = function(_, opts)
    -- config variable is the default configuration table for the setup function call
    local nls = require("null-ls")
    local h = require("null-ls.helpers")
    local u = require("null-ls.utils")

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    opts.diagnostics_format = "#{m} [#{c}] "
    opts.sources = {
      -- Set a formatternone
      nls.builtins.code_actions.gitsigns,
      nls.builtins.formatting.pyink.with {
        extra_args = {
          "--line-length=120",
        },
      },
      nls.builtins.diagnostics.mypy.with {
        extra_args = function()
          local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
          return { "--python-executable", (venv and venv .. "/bin/python3") or "python3" }
        end,
      },
      nls.builtins.formatting.stylua.with {
        args = function(params)
          local args = {
            "--stdin-filepath",
            "$FILENAME",
            "-",
          }
          if u.root_pattern(".stylua.toml")(params.root) then
            table.insert(args, 1, "--config-path")
            table.insert(args, 2, params.root .. "/.stylua.toml")
          elseif
            not u.root_pattern(".stylua.toml")(params.root) and not u.root_pattern(".editorconfig")(params.root)
          then
            table.insert(args, 1, "--search-parent-directories")
          end
          return args
        end,
      },
      require("none-ls-luacheck.diagnostics.luacheck").with {
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
        method = nls.methods.DIAGNOSTICS_ON_SAVE,
        generator_opts = require("astrocore").extend_tbl(
          require("none-ls-luacheck.diagnostics.luacheck"),
          { multiple_files = true }
        ),
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
    return opts -- return final config table
  end,
  specs = {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings
      maps.n["<Leader>ln"] = { function() require("null-ls").toggle {} end, desc = "None-ls toggle" }
    end,
  },
}
