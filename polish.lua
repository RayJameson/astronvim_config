return function()
  vim.api.nvim_set_var("python3_host_prog", "$HOME/.pyenv/versions/neovim_base_venv/bin/python3")
  vim.api.nvim_set_var(
    "node_host_prog",
    "/usr/local/bin/neovim-node-host"
    -- nvm doesn't work with this variable, make symlink to destination above
  )
  vim.api.nvim_set_option(
    "langmap",
    "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
  )
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
  -----------------------------------------------------------------------------//
  -- Absolutely fantastic function from stoeffel/.dotfiles which allows you to
  -- repeat macros across a visual range
  ------------------------------------------------------------------------------
  -- TODO: converting this to lua does not work for some obscure reason.
  vim.cmd([[
    function! ExecuteMacroOverVisualRange()
      execute ":'<,'>normal @".nr2char(getchar())
    endfunction
  ]])
  -----------------------------------------------------------------------------//
  -- Multiple Cursor Replacement
  -- http://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
  -----------------------------------------------------------------------------//

  -- 1. Position the cursor over a word; alternatively, make a selection.
  -- 2. Hit cq to start recording the macro.
  -- 3. Once you are done with the macro, go back to normal mode.
  -- 4. Hit Enter to repeat the macro over search matches.

  vim.cmd([[
  let g:mc = "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>"

  nnoremap cn *``cgn
  nnoremap cN *``cgN

  vnoremap <expr> cn g:mc . "``cgn"
  vnoremap <expr> cN g:mc . "``cgN"

  function! SetupCR()
    nnoremap <Enter> :nnoremap <lt>Enter> n@z<CR>q:<C-u>let @z=strpart(@z,0,strlen(@z)-1)<CR>n@z
  endfunction

  nnoremap cq :call SetupCR()<CR>*``qz
  nnoremap cQ :call SetupCR()<CR>#``qz

  vnoremap <expr> cq ":\<C-u>call SetupCR()\<CR>" . "gv" . g:mc . "``qz"
  vnoremap <expr> cQ ":\<C-u>call SetupCR()\<CR>" . "gv" . substitute(g:mc, '/', '?', 'g') . "``qz"
]])

  -- Set up custom filetypes
  vim.filetype.add {
    filename = {
      ["poetry.lock"] = "toml",
      ["%.?zshrc"] = "sh",
    },
    extension = {
      tlua = "lua",
      zsh = "sh",
    },
    pattern = {
      -- ["~/%.config/foo/.*"] = "fooscript",
      ["%.gitconfig.*"] = "gitconfig",
      [".*/%.vscode/.+%.json"] = "jsonc",
    },
  }

  local better_luafile = require("user.better_luafile")
  vim.api.nvim_create_user_command(
    "BetterLuafile",
    function(opts) better_luafile.call(opts.fargs, "horizontal", 15, true) end,
    { nargs = "?" }
  )
  require("user.autocmds")
  if vim.g.neovide then
    -- local alpha = function() return string.format("%x", math.floor((255 * vim.g.neovide_transparency_point) or 0.8)) end
    -- Set transparency and background color (title bar color)
    if vim.loop.os_uname().sysname == "Darwin" then
      -- vim.g.neovide_transparency = 0.0
      -- vim.g.neovide_transparency_point = 0.8
      -- vim.g.neovide_background_color = "#0f1117" .. alpha()
      vim.g.neovide_input_macos_alt_is_meta = true
    end
    vim.g.neovide_cursor_antialiasing = true
    vim.o.guifont = "LigaMesloLGSDZ Nerd Font Mono,Source Code Pro:h20"
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_refresh_rate_idle = 5
  end
  vim.api.nvim_create_user_command(
    "Scratch",
    function()
      vim.cmd([[
      15split
      noswapfile hide enew
      setlocal buftype=nofile
      setlocal bufhidden=hide
      setlocal nobuflisted
    ]])
    end,
    {}
  )
end
