-- set vim options here (vim.<first_key>.<second_key> = value)
return {
  opt = {
    -- set to true or false etc.
    relativenumber = true, -- sets vim.opt.relativenumber
    number = true, -- sets vim.opt.number
    spell = false, -- sets vim.opt.spell
    wrap = false, -- sets vim.opt.wrap
    showtabline = 0,
    -- set to true or false etc.
    signcolumn = "auto:9", -- sets vim.opt.signcolumn to auto
    colorcolumn = "80",
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    foldcolumn = "1", -- '0' is not bad
    foldlevelstart = 99,
    foldenable = true,
    foldmethod = "manual",
    smarttab = true,
    clipboard = "",
    autoindent = true,
    smartindent = true,
    autochdir = false,
    list = true,
    showbreak = "↪ ",
    title = true,
    titlestring = "%<%F%=%l/%L - nvim",
    listchars = {
      tab = "→ ",
      eol = "↲",
      nbsp = "␣",
      trail = "•",
      extends = "⟩",
      precedes = "⟨",
    },
    fillchars = {
      eob = " ",
      fold = " ",
      foldopen = "",
      foldsep = "│",
      foldclose = "",
    },
  },
  g = {
    mapleader = " ", -- sets vim.g.mapleader
    autoformat_enabled = false, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    cmp_enabled = true, -- enable completion at start
    autopairs_enabled = true, -- enable autopairs at start
    diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    ui_notifications_enabled = true, -- disable notifications when toggling UI elements
  },
}
-- If you need more control, you can use the function()...end notation
-- return function(local_vim)
--   local_vim.opt.relativenumber = true
--   local_vim.g.mapleader = " "
--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
--
--   return local_vim
-- end
