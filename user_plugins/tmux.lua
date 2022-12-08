return function()
    require("tmux").setup {
        copy_sync = {
            enable = true,
            sync_registers = false,
            sync_clipboard = true,
        },
        navigation = {
            cycle_navigation = true,
            enable_default_keybindings = true,
        },
        resize = {
            enable_default_keybindings = true,
        },
    }
end
