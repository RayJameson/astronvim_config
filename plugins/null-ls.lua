return function(config) -- overrides `require("null-ls").setup(config)`
    -- config variable is the default configuration table for the setup function call
    local null_ls = require("null-ls")

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
        -- Set a formatter
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.yapf.with({
            extra_args = { "--style={based_on_style: pep8}" },
        }),
        null_ls.builtins.formatting.usort,
        null_ls.builtins.formatting.stylua.with({
            extra_args = {
                "--indent-type=Spaces",
                "--indent-width=4",
                "--quote-style=AutoPreferDouble",
                "--call-parentheses=Always",
                "--column-width=120",
            },
        }),
        null_ls.builtins.diagnostics.pylint.with({
            env = function(params) return { PYTHONPATH = params.root } end,
        }),
        null_ls.builtins.diagnostics.luacheck.with({
            command = "luacheck",
            extra_args = {},
            filetypes = { "lua" },

            -- force luacheck to find its '.luacheckrc' file
            cwd = function(params)
                -- falls back to root if return value is nil
                return params.root:match(".luacheckrc")
            end,

            -- cwd = nls_cache.by_bufnr(function(params)
            --   return root_pattern ".luacheckrc" (params.bufname)
            -- end),

            -- runtime_condition = nls_cache.by_bufnr(function(params)
            --   return path.exists(path.join(params.root, ".luacheckrc"))
            -- end),
        }),
    }
    return config -- return final config table
end
