return {
    after = "nvim-treesitter",
    requires = {
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-python",
    },
    config = function()
        require("neotest").setup {
            adapters = {
                require("neotest-python"),
            },
        }
        vim.api.nvim_create_user_command("NeotestRun", require("neotest").run.run, {})
        vim.api.nvim_create_user_command("NeotestRunFile", function()
            require("neotest").run.run(vim.fn.expand("%"))
        end, {})
        vim.api.nvim_create_user_command("NeotestRunDap", function()
            require("neotest").run.run { strategy = "dap" }
        end, {})
        vim.api.nvim_create_user_command("NeotestStop", function()
            require("neotest").run.stop()
        end, {})
        vim.api.nvim_create_user_command("NeotestAttach", function()
            require("neotest").run.attach()
        end, {})
        vim.api.nvim_create_user_command("NeotestSummaryToggle", function()
            require("neotest").summary.toggle()
        end, {})
        vim.api.nvim_create_user_command("NeotestOutput", function()
            require("neotest").output.open { enter = true }
        end, {})
        vim.api.nvim_create_user_command("NeotestOutputToggle", function()
            require("neotest").output_panel.toggle()
        end, {})
        vim.api.nvim_create_user_command("NeotestJumpPreviousFailed", function()
            require("neotest").jump.prev({ status = "failed" })
        end, {})
        vim.api.nvim_create_user_command("NeotestJumpNextFailed", function()
            require("neotest").jump.next({ status = "failed" })
        end, {})
    end,
}
