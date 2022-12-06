return {
    opt = {
        -- set to true or false etc.
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
        ignorecase = true,
        smartcase = true,
        colorcolumn = "120",
        expandtab = true,
        tabstop = 4,
        softtabstop = 4,
        shiftwidth = 4,
        smarttab = true,
        clipboard = "",
        autoindent = true,
        smartindent = true,
        autochdir = false,
        list = true,
        showbreak = "↪ ",
        listchars = {
            tab = "→ ",
            eol = "↲",
            nbsp = "␣",
            trail = "•",
            extends = "⟩",
            precedes = "⟨",
        },
    },
    g = {
        mapleader = " ", -- sets vim.g.mapleader
        autoformat_enabled = false, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
        cmp_enabled = true, -- enable completion at start
        autopairs_enabled = true, -- enable autopairs at start
        diagnostics_enabled = true, -- enable diagnostics at start
        status_diagnostics_enabled = true, -- enable diagnostics in statusline
        icons_enabled = true, -- disable icons in the ui (disable if no nerd font is available, requires :packersync after changing)
        ui_notifications_enabled = true, -- disable notifications when toggling ui elements
        undotree_setfocuswhentoggle = true,
        undotree_splitwidth = 40,
    },
}
