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
    incremental_selection = { enable = true },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = { query = "@function.outer", desc = "Select whole function" },
                ["if"] = { query = "@function.inner", desc = "Select inner part of function" },
                ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                ["ii"] = { query = "@block.inner", desc = "Select inner part of indent" },
                ["ai"] = { query = "@block.outer", desc = "Select outer part of indent" },
            },
            selection_modes = {
                ["@parameter.outer"] = "v", -- charwise
                ["@function.outer"] = "V", -- linewise
                ["@class.outer"] = "<c-v>", -- blockwise
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]f"] = "@function.outer",
                ["]c"] = "@class.outer",
            },
            goto_next_end = {
                ["]F"] = "@function.outer",
                ["]C"] = "@class.outer",
                ["]/"] = "@comment.outer",
            },
            goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[c"] = "@class.outer",
            },
            goto_previous_end = {
                ["[F"] = "@function.outer",
                ["[C"] = "@class.outer",
                ["[/"] = "@comment.outer",
            },
        },
        swap = {
            enable = false,
        },
    },
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
}
