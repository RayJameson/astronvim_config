return function(client, bufnr)
  if client.name == "ruff_lsp" then client.server_capabilities.hoverProvider = false end
  if client.name == "pyright" then
    local enabled_capabilities = {
      textDocumentSync = true,
      completionProvider = true,
      documentHighlightProvider = true,
      documentSymbolProvider = true,
      workspaceSymbolProvider = true,
    }
    for capability_name, _ in pairs(client.server_capabilities) do
      if not enabled_capabilities[capability_name] then client.server_capabilities[capability_name] = false end
    end
  end
end
