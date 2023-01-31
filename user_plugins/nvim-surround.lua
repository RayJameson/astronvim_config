local function add_to_lazy_file_plugins(plugin)
    table.insert(astronvim.file_plugins, plugin)
end


return {
    opt = true,
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup()
    end,
    setup = add_to_lazy_file_plugins("nvim-surround"),
}
