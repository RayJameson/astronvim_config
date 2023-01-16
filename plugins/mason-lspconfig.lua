return { -- overrides `require("mason-lspconfig").setup(...)`
    ensure_installed = {
        "sumneko_lua",
        "pyright",
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
