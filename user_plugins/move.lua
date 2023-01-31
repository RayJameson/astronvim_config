local function add_to_lazy_file_plugins(plugin)
    table.insert(astronvim.file_plugins, plugin)
end

return {
    opt = true,
    setup = add_to_lazy_file_plugins("move.nvim"),
}
