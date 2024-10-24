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
  if jit.os == "OSX" then
    vim.g.neovide_input_macos_option_key_is_meta = "both"
    vim.o.guifont = "Iosevka Nerd Font Mono Condensed ExtraLight:h16"
    vim.keymap.set("v", "<D-c>", '"+y') -- Copy
    vim.keymap.set("n", "<D-v>", '"+p') -- Paste normal mode
    vim.keymap.set("v", "<D-v>", '"+p') -- Paste visual mode
    vim.keymap.set("c", "<D-v>", "<C-r>+") -- Paste command mode
    vim.keymap.set("i", "<D-v>", '<C-r>+"') -- Paste insert mode
    vim.keymap.set("t", "<D-v>", '<C-\\><C-n>"+pi', { desc = "Paste from system clipboard" })
  else
    vim.o.guifont = "Iosevka Nerd Font Mono Condensed ExtraLight:h14"
    vim.keymap.set("x", "<C-S-C>", '"+y', { desc = "Copy to system clipboard" })
    vim.keymap.set("n", "<C-S-V>", '"+p', { desc = "Paste from system clipboard" })
    vim.keymap.set("i", "<C-S-V>", "<C-r>+", { desc = "Paste from system clipboard" })
    vim.keymap.set("t", "<C-S-V>", '<C-\\><C-n>"+pi', { desc = "Paste from system clipboard" })
  end
  vim.g.neovide_cursor_antialiasing = true
  vim.o.linespace = -1
  vim.g.neovide_scale_factor = 1.6
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
