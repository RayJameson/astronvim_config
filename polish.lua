return function()
    local is_available = astronvim.is_available
    if is_available("null-ls") then
        vim.api.nvim_create_user_command("LinterRestart", function()
            require("null-ls.client")._reset()
            vim.cmd.edit()
        end, {})
    end

    vim.api.nvim_create_autocmd({ "TextYankPost" }, {
        pattern = "*",
        callback = function() vim.highlight.on_yank { higroup = "IncSearch", timeout = 100 } end,
    })

    if is_available("harpoon") then
        vim.api.nvim_create_user_command("HarpoonToggle", function() require("harpoon.ui").toggle_quick_menu() end, {})
        vim.api.nvim_create_user_command("HarpoonAddFile", function() require("harpoon.mark").add_file() end, {})
    end

    vim.api.nvim_set_var("python3_host_prog", "$HOME/.pyenv/versions/neovim_base_venv/bin/python3")
    -- Set up custom filetypes
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
