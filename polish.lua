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

    vim.api.nvim_create_augroup("relative_number_switch", { clear = true })
    vim.api.nvim_create_autocmd("InsertEnter", {
        pattern = "*",
        group = "relative_number_switch",
        callback = function()
            if vim.wo.relativenumber then
                vim.wo.relativenumber = false
                vim.w.adaptive_relative_number_state = true
            end
        end,
    })

    if vim.fn.has("mac") then
        vim.cmd([[
            function OpenMarkdownPreview (url)
                execute "silent ! open -a 'Brave Browser' -n --args --new-window " . a:url
            endfunction
            let g:mkdp_browserfunc = 'OpenMarkdownPreview'
        ]])
    end
    vim.api.nvim_create_autocmd("InsertLeave", {
        pattern = "*",
        group = "relative_number_switch",
        callback = function()
            if vim.w.adaptive_relative_number_state then
                vim.wo.relativenumber = true
                vim.w.adaptive_relative_number_state = nil
            end
        end,
    })

    vim.lsp.handlers["workspace/diagnostic/refresh"] = function(_, _, ctx)
        local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
        pcall(vim.diagnostic.reset, ns)
        return true
    end

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
