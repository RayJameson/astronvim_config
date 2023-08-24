return {
  on_attach = function(_, bufnr)
    -- HACK: temporary overwriting `vim.notify` function to prevent "No code actions available" notification
    local silent = function(fn, ...)
      local old_notify = vim.notify
      ---@diagnostic disable-next-line
      vim.notify = function(msg, ...) end -- luacheck: ignore 212
      fn(...)
      vim.wait(100)
      vim.notify = old_notify
    end

    -- Organize imports via code action on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        silent(vim.lsp.buf.code_action, {
          context = { only = { "source.fixAll.ruff" } },
          apply = true,
        })
      end,
      group = vim.api.nvim_create_augroup("RuffLspCodeAction", { clear = true }),
    })
  end,
  init_options = {
    settings = {
      args = {
        "--select=ALL",
        "--ignore=D,PT009,ANN002,ANN003,ANN101,ANN102,ANN401,A003,RUF001,RUF002,RUF003,RET504,PD008,TD001,TD002,TD003,S101",
        "--line-length=79",
      },
    },
  },
}
