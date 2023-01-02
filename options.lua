return {
    opt = {
        -- set to true or false etc.
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        colorcolumn = "120",
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
        foldcolumn = "1", -- '0' is not bad
        foldlevel = 99, -- Using ufo provider need a large value, feel free to decrease the value
        foldlevelstart = 99,
        foldenable = true,
        foldmethod = "manual",
    },
    g = {
        heirline_bufferline = true, -- enable heirline bufferline (TODO v3: remove this option and make it default)
        autoformat_enabled = false, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
        undotree_setfocuswhentoggle = true,
        undotree_splitwidth = 40,
    },
}
