return {
    event_handlers = {
        {
            event = "file_opened",
            handler = function(file_path)
                --auto close
                require("neo-tree").close_all()
            end,
        },
    },
    window = {
        auto_expand_width = true,
        mappings = {
            ["a"] = {
                "add",
                config = {
                    show_path = "absolute", -- "none", "relative", "absolute"
                },
            },
            ["c"] = {
                "copy",
                config = {
                    show_path = "absolute",
                },
            },
            ["m"] = {
                "move",
                config = {
                    show_path = "absolute",
                },
            },
            ["A"] = "noop",
        },
    },
    filesystem = {
        filtered_items = {
            visible = true,
        },
        follow_current_file = true,
        window = {
            mappings = {
                ["/"] = "noop",
                ["s"] = "noop",
                ["S"] = "noop",
                ["g/"] = "fuzzy_finder",
                ["Z"] = "expand_all_nodes",
                ["<C-s>"] = "open_split",
                ["<C-v>"] = "open_vsplit",
            },
        },
    },
}
