return {
    settings = {
        pylsp = {
            plugins = {
                pyflakes = { enabled = true },
                autopep8 = { enabled = false },
                pycodestyle = {
                    enabled = true,
                    maxLineLength = 120,
                },
                flake8 = {
                    enabled = false,
                    maxLineLength = 120,
                },
            },
        },
    },
}
