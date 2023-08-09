local is_available = require("astronvim.utils").is_available
return function(maps)
  maps.n["gl"] = false
  maps.n["gy"] = false
  if maps.n.gd then maps.n.gd[1] = function() vim.lsp.buf.definition() end end
  if maps.n.gI then maps.n.gI[1] = function() vim.lsp.buf.implementation() end end
  if maps.n.gr then maps.n.gr[1] = function() vim.lsp.buf.references() end end
  if maps.n.gT then maps.n.gT[1] = function() vim.lsp.buf.type_definition() end end
  if maps.n["<leader>lG"] then maps.n["<leader>lG"][1] = function() vim.lsp.buf.workspace_symbol() end end
  if maps.n["<leader>lR"] then maps.n["<leader>lR"][1] = function() vim.lsp.buf.references() end end
  if is_available("trouble.nvim") then
    if maps.n.gd then maps.n.gd[1] = function() require("trouble").open("lsp_definitions") end end
    if maps.n.gI then maps.n.gI[1] = function() require("trouble").open("lsp_implementations") end end
    if maps.n.gr then maps.n.gr[1] = function() require("trouble").open("lsp_references") end end
    if maps.n.gT then maps.n.gT[1] = function() require("trouble").open("lsp_type_definitions") end end
    if maps.n["<leader>lR"] then maps.n["<leader>lR"][1] = function() require("trouble").open("lsp_references") end end
  end
  return maps
end
