return {
    -- easily add or disable built in mappings added during LSP attaching
    n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
        ["<leader>lF"] = { "<cmd>FormatModifications<CR>", desc = "Format changed code" },
    },
}
