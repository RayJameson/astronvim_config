return { -- overrides `require("mason-null-ls").setup(...)`
    automatic_installation = true,
    ensure_installed = {
        -- Bash
        "bash-language-server",
        "beutysh",
        -- Python
        "python-lsp-server",
        "pylint",
        "usort",
        "yapf",
        -- Rust
        "rust-analyzer",
        "rustfmt",
        -- Git
        "gitlint",
        "commitlint",
        -- Lua
        "stylua",
        "luacheck",
        -- Other
        "prettier",
    },
    -- setup_handlers = {}
}
