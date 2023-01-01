return function()
    require("diffview").setup {
        file_history_panel = {
            log_options = {
                git = {
                    single_file = {
                        max_count = 512,
                        follow = true,
                    },
                    multi_file = {
                        max_count = 128,
                        -- follow = false   -- `follow` only applies to single-file history
                    },
                },
            },
        },
    }
end
