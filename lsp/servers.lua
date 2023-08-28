local servers = {
  -- enable servers that you already have installed without mason
  -- "pyright"
}
local ok, custom_servers = pcall(require, "user.lsp.custom_servers")
if ok then servers = vim.list_extend(servers, custom_servers) end

return servers
