return function(config) -- overrides `require("null-ls").setup(config)`
    -- config variable is the default configuration table for the setup function call
    -- local null_ls = require("null-ls")
    local is_available, null_ls = pcall(require, "null-ls")
    if not is_available then return {} end

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
        -- Set a formatter
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.stylua.with {
            extra_args = {
                "--indent-type=Spaces",
                "--indent-width=4",
                "--quote-style=AutoPreferDouble",
                "--call-parentheses=NoSingleTable",
                "--column-width=120",
            },
        },
        null_ls.builtins.diagnostics.luacheck.with {
            command = "luacheck",
            extra_args = { "-d" },
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
        },
    }
    config.on_attach = function(client, bufnr)
        local lsp_format_modifications_ok, lsp_format_modifications = pcall(require, "lsp-format-modifications")
        if lsp_format_modifications_ok then
            lsp_format_modifications.attach(client, bufnr, { format_on_save = false })
            vim.keymap.set("n", "<leader>lF", "<CMD>FormatModifications<CR>", { desc = "Format changed code" })
        end
    end
    vim.api.nvim_create_user_command("NullLsRestart", function()
        require("null-ls.client")._reset()
        vim.cmd.edit()
    end, {})
    return config -- return final config table
end
