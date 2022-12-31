return function(config)
    local neodev_config = require("user.user_plugins.neodev")
    require("neodev").setup(neodev_config)
    config.settings = {
        Lua = {
            hint = {
                enable = true,
            },
            workspace = {
                checkThirdParty = false,
            },
            runtime = {
                version = "Lua 5.4",
                -- version = "LuaJIT",
            },
            diagnostics = {
                disable = { "lowercase-global" },
            },
        },
    }
    return config
end
