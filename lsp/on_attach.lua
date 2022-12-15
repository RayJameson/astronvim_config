return function(client, bufnr)
    local lsp_format_modifications = require("lsp-format-modifications")
    lsp_format_modifications.attach(client, bufnr, { format_on_save = false })

    if client.server_capabilities.inlayHintProvider then
        local inlayhints_avail, inlayhints = pcall(require, "lsp-inlayhints")
        if inlayhints_avail then
            inlayhints.on_attach(client, bufnr)
            vim.keymap.set("n", "<leader>uH", function() inlayhints.toggle() end, { desc = "Toggle inlay hints" })
        end
    end
end
