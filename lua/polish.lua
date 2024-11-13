local function escape(str)
  -- You need to escape these characters to work correctly
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

-- Recommended to use lua template string
local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

vim.opt.langmap = vim.fn.join({
  -- | `to` should be first     | `from` should be second
  escape(ru_shift)
    .. ";"
    .. escape(en_shift),
  escape(ru) .. ";" .. escape(en),
}, ",")

if jit.os == "OSX" then
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

-- Set up custom filetypes
vim.filetype.add {
  filename = {
    ["poetry.lock"] = "toml",
    ["%.?zshrc"] = "zsh",
  },
  extension = {
    tlua = "lua",
    rasi = "rasi",
  },
  pattern = {
    -- ["~/%.config/foo/.*"] = "fooscript",
    ["%.gitconfig.*"] = "gitconfig",
    [".*/%.vscode/.+%.json"] = "jsonc",
  },
}

local better_luafile = require("better_luafile")
vim.api.nvim_create_user_command(
  "BetterLuafile",
  function(opts) better_luafile.call(opts.fargs, "horizontal", 15, true) end,
  { nargs = "?" }
)
require("autocmds")

if vim.g.neovide then
  local copy_shortcuts = { "<C-S-C>" }
  local paste_shortcuts = { "<C-S-V>" }
  vim.g.neovide_scale_factor = 1.6
  if jit.os == "OSX" then
    table.insert(copy_shortcuts, "<D-c>")
    table.insert(paste_shortcuts, "<D-v>")
    vim.g.neovide_input_macos_option_key_is_meta = "both"
    vim.o.guifont = "Iosevka Nerd Font Mono Condensed ExtraLight:h16"
  else
    vim.o.guifont = "Iosevka Nerd Font Mono Condensed ExtraLight:h14"
    vim.g.neovide_scale_factor = 1.4
  end
  for _, paste_shortcut in ipairs(paste_shortcuts) do
    for _, mode in ipairs { "n", "i", "x", "v", "t", "c" } do
      vim.keymap.set(
        mode,
        paste_shortcut,
        function() vim.api.nvim_paste(vim.fn.getreg("+"), true, -1) end,
        { desc = "Paste from system clipboard" }
      )
    end
  end
  for _, copy_shortcut in ipairs(copy_shortcuts) do
    vim.keymap.set("x", copy_shortcut, '"+y', { desc = "Copy to system clipboard" })
  end
  vim.g.neovide_cursor_antialiasing = true
  vim.o.linespace = -1
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
vim.tbl_map(function(v) vim.api.nvim_del_keymap("n", "gr" .. v) end, { "r", "a", "n" })
