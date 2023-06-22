return function(client, bufnr)
  if client.supports_method("textDocument/rangeFormatting") then
    local lsp_format_modifications_ok, lsp_format_modifications =
      pcall(require, "lsp-format-modifications")
    if lsp_format_modifications_ok then
      lsp_format_modifications.attach(
        client,
        bufnr,
        { format_on_save = false }
      )
      vim.keymap.set(
        "n",
        "<leader>lF",
        "<CMD>FormatModifications<CR>",
        { desc = "Format changed code" }
      )
    end
  end

  if client.name == "ruff_lsp" then
    client.server_capabilities.hoverProvider = false
  end
  if client.name == "pyright" then
    local enabled_capabilities = {
      textDocumentSync = true,
      completionProvider = true,
      documentHighlightProvider = true,
      documentSymbolProvider = true,
      workspaceSymbolProvider = true,
    }
    for capability_name, _ in pairs(client.server_capabilities) do
      if not enabled_capabilities[capability_name] then
        client.server_capabilities[capability_name] = false
      end
    end
  end
end
