return {
    yati = {
        enable = true,
        -- Whether to enable lazy mode (recommend to enable this if bad indent happens frequently)
        default_lazy = false,
        -- Determine the fallback method used when we cannot calculate indent by tree-sitter
        --   "auto": fallback to vim auto indent
        --   "asis": use current indent as-is
        --   "cindent": see `:h cindent()`
        -- Or a custom function return the final indent result.
        default_fallback = "auto",
        -- And optionally, disable the conflict warning emitted by plugin
        suppress_conflict_warning = true,
    },
    matchup = {
        enable = true,
    },
    indent = {
        enable = false,
    },
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
        local max_filesize = 500 * 1024 -- 500 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
}
