return {
    -- first key is the mode, n == normal mode
    n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
            -- third key is the key to bring up next level and its displayed
            -- group name in which-key top level menu
            ["m"] = { name = "Markdown" },
            ["r"] = {
                name = "Code runner",
            },
            ["T"] = { name = "Trouble" },
            ["D"] = { name = "Debug" },
            ["M"] = { name = "Mind Notes" },
        },
    },
    v = {
        ["<leader>"] = {
            ["g"] = { name = "Diff View" },
            ["l"] = { name = "LSP" },
        },
    },
}
