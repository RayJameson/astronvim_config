return {
    opt = true,
    run = function()
        vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
}
