return function(config)
    local neodev_config = require("user.user_plugins.neodev")
    require("neodev").setup(neodev_config)
    config.settings = {
        Lua = {
            hint = {
                enable = true,
            },
            workspace = {
                checkThirdParty = true,
            },
            diagnostics = {
                disable = { "lowercase-global" },
            },
            codelens = {
                enable = true,
            },
        },
    }
    return config
end
