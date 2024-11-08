---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    ---@diagnostic disable: missing-fields
    config = {
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            lens = {
              references = {
                method = {
                  enable = true,
                },
                trait = {
                  enable = true,
                },
                adt = {
                  enable = true,
                },
                enumVariant = {
                  enable = true,
                },
              },
            },
            diagnostics = {
              styleLints = {
                enable = true,
              }
            },
            inlayHints = {
              implicitDrops = {
                enable = true,
              }
            },
            cargo = {
              features = "all"
            },
            completion = {
              postfix = {
                enable = false,
              },
            },
            check = {
              command = "clippy",
              extraArgs = { "--no-deps" },
              features = "all",
            },
            checkOnSave = true,
          },
        },
      },
    },
  },
}
