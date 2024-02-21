return {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      completion = {
        postfix = {
          enable = false,
        },
      },
      checkOnSave = {
        -- default: `cargo check`
        allFeatures = true,
        command = "clippy",
        extraArgs = { "--no-deps" },
      },
    },
  },
}
