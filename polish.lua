return function()
    vim.cmd([[
            " autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=100}
            :set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
            command! Refactoring execute "lua require('telescope').extensions.refactoring.refactors()"
            augroup remember_folds
            autocmd!
            autocmd BufWinLeave *.* mkview
            autocmd BufWinEnter *.* silent! loadview
            augroup END
            autocmd BufWritePost *.* TSDisable rainbow | TSEnable rainbow
        ]])

    local is_available = astronvim.is_available
    vim.api.nvim_create_user_command("LinterRestart", function()
        require("null-ls.client")._reset()
        vim.cmd.edit()
    end, {})

    vim.api.nvim_create_autocmd({ "TextYankPost" }, {
        pattern = "*",
        callback = function() vim.highlight.on_yank { higroup = "IncSearch", timeout = 100 } end,
    })

    vim.api.nvim_set_var("python3_host_prog", "$HOME/.pyenv/versions/neovim_base_venv/bin/python3")
    -- Set up custom filetypes
    vim.filetype.add {
        filename = {
            ["poetry.lock"] = "toml",
        },
        extension = {
            tlua = "lua",
        },
        -- pattern = {
        --   ["~/%.config/foo/.*"] = "fooscript",
        -- },
    }
end
