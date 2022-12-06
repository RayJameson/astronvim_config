return {
    -- first key is the mode, n == normal mode
    n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
            -- third key is the key to bring up next level and its displayed
            -- group name in which-key top level menu
            ["y"] = { '"+y', "yank +clipboard" },
            ["Y"] = { '"+y$', "Yank +clipboard" },
            ["d"] = { '"_d', "delete noregister" },
            ["b"] = { name = "Buffer" },
            ["m"] = {
                name = "Markdown",
                ["M"] = { "<cmd>Glow<CR>", "Markdown Glow" },
                ["m"] = { "<cmd>MarkdownPreview<CR>", "MarkdownPreview" },
                ["t"] = { "<cmd>MarkdownPreviewToggle<CR>", "MarkdownPreview Toggle" },
                ["s"] = { "<cmd>MarkdownPreviewStop<CR>", "MarkdownPreview Stop" },
            },
            ["r"] = {
                name = "Code runner",
                ["r"] = { "<cmd>RunCode<CR>", "Run code" },
                ["f"] = { "<cmd>RunFile<CR>", "Run file" },
                ["t"] = { "<cmd>RunFile tab<CR>", "Run file tab" },
                ["b"] = { "<cmd>RunFile buf<CR>", "Run file buf" },
                ["c"] = { "<cmd>RunClose<CR>", "Close runner" },
            },
            ["T"] = {
                name = "Trouble",
                ["r"] = { "<cmd>Trouble lsp_references<CR>", "References" },
                ["f"] = { "<cmd>Trouble lsp_definitions<CR>", "Definitions" },
                ["d"] = { "<cmd>Trouble document_diagnostics<CR>", "Diagnostics" },
                ["q"] = { "<cmd>Trouble quickfix<CR>", "QuickFix" },
                ["l"] = { "<cmd>Trouble loclist<CR>", "LocationList" },
                ["w"] = {
                    "<cmd>Trouble workspace_diagnostics<CR>",
                    "Wordspace Diagnostics",
                },
                ["t"] = { "<cmd>TodoTrouble<CR>", "TODO list" },
            },
            ["D"] = {
                name = "Debug",
                ["b"] = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Breakpoint" },
                ["c"] = { "<cmd>lua require'dap'.continue()<CR>", "Continue" },
                ["i"] = { "<cmd>lua require'dap'.step_into()<CR>", "Into" },
                ["o"] = { "<cmd>lua require'dap'.step_over()<CR>", "Over" },
                ["O"] = { "<cmd>lua require'dap'.step_out()<CR>", "Out" },
                ["r"] = { "<cmd>lua require'dap'.repl.toggle()<CR>", "Repl" },
                ["l"] = { "<cmd>lua require'dap'.run_last()<CR>", "Last" },
                ["u"] = { "<cmd>lua require'dapui'.toggle()<CR>", "UI" },
                ["x"] = { "<cmd>lua require'dap'.terminate()<CR>", "Exit" },
            },
        },
    },
    v = {
        ["<leader>"] = {
            ["y"] = { '"+y', "yank +clipboard" },
            ["Y"] = { '"+y', "Yank +clipboard" },
            ["d"] = { '"_d', "delete noregister" },
            ["D"] = { '"_D', "Delete noregister" },
            ["r"] = { "<Esc><cmd>Refactoring<CR>", "Refactoring" },
        },
    },
    x = {
        ["<leader>"] = {
            ["p"] = { '"_dP', "Paste noregister" },
        },
    },
}
