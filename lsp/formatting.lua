return {
    -- control auto formatting on save
    format_on_save = {
        enabled = false, -- enable or disable format on save globally
    },
    disabled = { -- disable formatting capabilities for the listed language servers
        "sumneko_lua",
        "yamlls",
    },
    timeout_ms = 3000, -- default format timeout
}
