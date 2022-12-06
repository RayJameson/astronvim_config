return function()
    require("hlargs").setup {
        color = "#FF7A00", --"#ef9062",
        paint_arg_usages = true,
        excluded_argnames = {
            declarations = {
                python = { "self", "cls" },
                lua = { "self" },
            },
            usages = {
                python = { "self", "cls" },
                lua = { "self" },
                extras = {
                    named_parameters = true,
                },
            },
        },
    }
end
