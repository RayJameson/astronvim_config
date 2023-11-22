return {
  on_attach = function(client, bufnr)
    -- Organize imports and fix all lint warnings via code action on save
    client.server_capabilities.hoverProvider = false
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        local ms = vim.lsp.protocol.Methods
        local timeout_ms = 1000
        local params = vim.lsp.util.make_range_params()
        params.context = {
          only = { "source.fixAll.ruff" },
          triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Automatic,
          diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr),
        }
        local resp, err = client.request_sync(ms.textDocument_codeAction, params, timeout_ms, bufnr)
        if err ~= nil then return end
        if resp.result ~= nil and resp.result[1] ~= nil and resp.result[1].edit ~= nil then
          vim.lsp.util.apply_workspace_edit(resp.result[1].edit, client.offset_encoding)
        end
      end,
      group = vim.api.nvim_create_augroup("RuffLspCodeAction", { clear = true }),
    })
  end,
  init_options = {
    settings = {
      --"--ignore=D,PT009,ANN002,ANN003,ANN101,ANN102,ANN401,A003,RUF001,RUF002,RUF003,RET504,PD008,TD001,TD002,TD003,S101",
      args = {
        "--select=B,E,F,I,ANN,ASYNC,S,COM,C,ISC,PIE,PT,Q,TID,ARG,PLE,PLR,PLW,RUF",
        "--ignore=ANN101,RUF100,PLR0913,ANN102,ANN401,PLR2004,S101",
        "--line-length=120",
        "fixable=A,B,C,D,E,F,G,I,N,Q,S,T,W,ANN,ARG,BLE,COM,DJ,DTZ,EM,ERA,EXE,FBT,ICN,INP,ISC,NPY,PD,PGH,PIE,PL,PT,PTH,PYI,RET,RSE,RUF,SIM,SLF,TCH,TID,TRY,UP,YTT",
      },
    },
  },
}
