return function()
  vim.api.nvim_set_var(
    "python3_host_prog",
    "$HOME/.pyenv/versions/neovim_base_venv/bin/python3"
  )
  vim.api.nvim_set_var(
    "node_host_prog",
    "/usr/local/bin/neovim-node-host"
    -- nvm doesn't work with this variable, make symlink to destination above
  )
  vim.cmd([[
            :set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
            augroup remember_folds
            autocmd!
            autocmd BufWinLeave *.* mkview
            autocmd BufWinEnter *.* silent! loadview
            augroup END
            autocmd BufWritePost *.* TSDisable rainbow | TSEnable rainbow
        ]])

  if vim.fn.has("mac") then
    vim.cmd([[
            " function OpenMarkdownPreview (url)
            "     execute "silent ! open -a 'Brave Browser' -n --args --new-window " . a:url
            " endfunction
            function OpenMarkdownPreview (url)
                execute "silent ! open_little_arc " . a:url
            endfunction
            let g:mkdp_browserfunc = 'OpenMarkdownPreview'
        ]])
  end
  vim.lsp.handlers["workspace/diagnostic/refresh"] = function(_, _, ctx)
    local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
    pcall(vim.diagnostic.reset, ns)
    return true
  end

  -- Set up custom filetypes
  vim.filetype.add {
    filename = {
      ["poetry.lock"] = "toml",
      ["%.?zshrc"] = "sh",
    },
    extension = {
      tlua = "lua",
      html = "htmldjango",
      htmldjango = "html",
      log = "log",
      bash = "sh",
      zsh = "sh",
    },
    pattern = {
      -- ["~/%.config/foo/.*"] = "fooscript",
      ["%.gitconfig.*"] = "gitconfig",
    },
  }

  local better_luafile = require("user.better_luafile")
  vim.api.nvim_create_user_command("BetterLuafile", function(opts)
    better_luafile.call(opts.fargs, "horizontal", 15, true)
  end, { nargs = "?" })
  require("user.autocmds")
end
