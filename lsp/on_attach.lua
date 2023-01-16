return function(client, bufnr)
    if client.server_capabilities.inlayHintProvider then
        local is_available, inlayhints = pcall(require, "lsp-inlayhints")
        if is_available then
            inlayhints.on_attach(client, bufnr, false)
            vim.keymap.set("n", "<leader>uH", function()
                inlayhints.toggle()
            end, { desc = "Toggle inlay hints" })
            vim.cmd("hi! link LspInlayHint Comment")
        end
    end
end
