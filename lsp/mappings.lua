return {
    -- easily add or disable built in mappings added during LSP attaching
    n = {
        ["<leader>lF"] = { "<cmd>FormatModifications<CR>", desc = "Format changed code" },
        ["gr"] = { "<cmd>Trouble lsp_references<CR>", desc = "References" },
        ["gd"] = { "<cmd>Trouble lsp_definitions<CR>", desc = "Definitions" },
    },
}
