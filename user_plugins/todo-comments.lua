return function()
    require("todo-comments").setup {
        keywords = { TEST = { icon = " ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } } },
    }
end
