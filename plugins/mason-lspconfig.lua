return { -- overrides `require("mason-lspconfig").setup(...)`
    ensure_installed = {
        "sumneko_lua",
        -- "pylsp",
        "rust_analyzer",
        "html",
        "vimls",
        "yamlls",
        "dockerls",
        "jsonls",
        "taplo",
    },
    automatic_installation = true,
}
