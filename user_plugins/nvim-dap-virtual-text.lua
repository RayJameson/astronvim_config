return {
    after = "nvim-dap",
    config = function()
        require("nvim-dap-virtual-text").setup {}
    end,
}
