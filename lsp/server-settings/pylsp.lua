return {
    settings = {
        pylsp = {
            plugins = {
                pyflakes = {
                    enabled = true,
                },
                pycodestyle = {
                    enabled = true,
                    maxLineLength = 120,
                },
                flake8 = {
                    enabled = false,
                    maxLineLength = 120,
                },
                pydocstyle = {
                    enabled = false,
                },
                pylint = {
                    enabled = false,
                },
                yapf = {
                    enabled = false,
                },
            },
        },
    },
}
