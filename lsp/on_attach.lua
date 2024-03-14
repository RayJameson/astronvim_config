return function(client, bufnr)
  if vim.b[bufnr].large_buf then client.stop() end
end
