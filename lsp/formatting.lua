return {
  -- control auto formatting on save
  format_on_save = {
    enabled = false, -- enable or disable format on save globally
    allow_filetypes = { -- enable format on save for specified filetypes only
      -- "go",
    },
    ignore_filetypes = { -- disable format on save for specified filetypes
      -- "python",
    },
  },
  disabled = { -- disable formatting capabilities for the listed language servers
    -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
    "lua_ls",
    "jedi_language_server",
  },
  timeout_ms = 1000, -- default format timeout
}
