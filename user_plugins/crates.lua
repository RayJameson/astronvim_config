return {
    tag = "v0.3.0",
    after = "nvim-cmp",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
        require("crates").setup()
    end,
}
