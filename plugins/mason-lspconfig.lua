return { -- overrides `require("mason-lspconfig").setup(...)`
    ensure_installed = {
        "sumneko_lua",
        "pylsp",
        "rust_analyzer",
        "html",
        "cssls",
        "vimls",
        "yamlls",
        "dockerls",
        "jsonls",
        "taplo",
        "cssmodules_ls",
    },
    automatic_installation = true,
}
