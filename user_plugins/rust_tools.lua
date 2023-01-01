return function()
    require("rust-tools").setup {
        tools = {
            -- on_initialized = function() require("inlay-hints").set_all() end,
            -- inlay_hints = { auto = false },
        },
        server = astronvim.lsp.server_settings("rust_analyzer"), -- get the server settings and built in capabilities/on_attach
    }
end
