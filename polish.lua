return function()
    vim.api.nvim_create_autocmd({ "TextYankPost" }, {
        pattern = "*",
        callback = function() vim.highlight.on_yank { higroup = "IncSearch", timeout = 100 } end,
    })

    vim.api.nvim_set_var("python3_host_prog", "$HOME/.pyenv/versions/neovim_base_venv/bin/python3")
    -- Set up custom filetypes
    vim.cmd([[
            " autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=100}
            :set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
            augroup remember_folds
            autocmd!
            autocmd BufWinLeave *.* mkview
            autocmd BufWinEnter *.* silent! loadview
            augroup END
            autocmd BufWritePost *.* TSDisable rainbow | TSEnable rainbow
        ]])

    vim.filetype.add {
        filename = {
            ["poetry.lock"] = "toml",
            ["%.?zshrc"] = "sh",
        },
        extension = {
            tlua = "lua",
            html = "htmldjango",
        },
        pattern = {
            -- ["~/%.config/foo/.*"] = "fooscript",
            ["%.gitconfig.*"] = "gitconfig",
        },
    }
end
