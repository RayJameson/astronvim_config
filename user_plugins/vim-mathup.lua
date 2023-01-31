local function add_to_lazy_file_plugins(plugin)
    table.insert(astronvim.file_plugins, plugin)
end

return {
    opt = true,
    setup = add_to_lazy_file_plugins("vim-matchup"),
    config = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
}
