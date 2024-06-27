---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
      update_in_insert = false,
    },
    -- vim options can be configured here
    options = {
      opt = {
        -- set to true or false etc.
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        wrap = false, -- sets vim.opt.wrap
        showtabline = 0,
        -- set to true or false etc.
        signcolumn = "yes:1", -- sets vim.opt.signcolumn to auto
        swapfile = false,
        colorcolumn = "80",
        mouse = "",
        tabstop = 4,
        softtabstop = 4,
        shiftwidth = 4,
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
        timeoutlen = 300,
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
          foldclose = "",
        },
        grepprg = vim.fn.executable("rg") == 1 and "rg --vimgrep" or nil,
      },
      g = { -- vim.g.<key>
        node_host_prog = vim.env.HOME .. "/.nvm/versions/node/v20.3.0/bin/node",
        python3_host_prog = vim.env.HOME .. "/.pyenv/versions/neovim_base_venv/bin/python3",
        rustaceanvim = {
          tools = {
            float_win_config = {
              border = "rounded",
            },
          },
        },
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
  },
}
