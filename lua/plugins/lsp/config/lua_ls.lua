---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    ---@diagnostic disable: missing-fields
    config = {
      lua_ls = {
        settings = {
          Lua = {
            format = {
              enable = false,
            },
            hint = {
              enable = true,
              arrayIndex = "Disable",
            },
            workspace = {
              checkThirdParty = false,
            },
            diagnostics = {
              disable = { "lowercase-global" },
            },
            codelens = {
              enable = true,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      },
    },
  },
}
