return {
  on_attach = function(client, _)
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
  end,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
      }
    }
  }
}
