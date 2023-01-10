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
                yapf = {
                    enabled = false,
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
                mypy = {
                    enabled = false,
                },
                autopep8 = {
                    enabled = false,
                },
            },
        },
    },
}
