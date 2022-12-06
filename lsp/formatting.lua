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
        "sumneko_lua",
    },
    timeout_ms = 3000, -- default format timeout
    -- filter = function(client) -- fully override the default formatting function
    --   return true
    -- end
}
