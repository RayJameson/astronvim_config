return {
    ensure_installed = {
        "vim",
        "help",
        "lua",
        "python",
        "rust",
        "javascript",
        "html",
        "css",
        "json",
        "toml",
        "yaml",
        "markdown",
    },
    auto_install = true,
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then return true end
    end,
}
