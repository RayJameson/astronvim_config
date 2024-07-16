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

local better_luafile = require("better_luafile")
vim.api.nvim_create_user_command(
  "BetterLuafile",
  function(opts) better_luafile.call(opts.fargs, "horizontal", 15, true) end,
  { nargs = "?" }
)
require("autocmds")
if vim.g.neovide then
  -- local alpha = function() return string.format("%x", math.floor((255 * vim.g.neovide_transparency_point) or 0.8)) end
  -- Set transparency and background color (title bar color)
  if jit.os:find("OSX") then
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
for _, v in ipairs { "r", "a", "n" } do
  vim.api.nvim_del_keymap("n", "gr" .. v)
end
