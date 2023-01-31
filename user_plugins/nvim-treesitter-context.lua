return {
    opt = true,
    requires = { "nvim-treesitter/nvim-treesitter" },
    after = "nvim-treesitter",
    config = function()
        require("treesitter-context").setup()
    end,
}
