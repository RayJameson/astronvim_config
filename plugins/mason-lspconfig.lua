return { -- overrides `require("mason-lspconfig").setup(...)`
    ensure_installed = {
        "sumneko_lua",
        "pyright",
        "jedi_language_server",
        "ruff_lsp",
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
