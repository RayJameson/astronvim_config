---@type LazySpec
return vim.tbl_map(function(plugin) return { plugin, enabled = false } end, {
    "goolord/alpha-nvim",
    "s1n7ax/nvim-window-picker",
    "nvim-neo-tree/neo-tree.nvim",
    "stevearc/resession.nvim",
    "stevearc/aerial.nvim",
})
