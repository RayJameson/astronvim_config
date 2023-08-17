return {
  "scalameta/nvim-metals",
  dependencies = "nvim-lua/plenary.nvim",
  init = function()
    vim.env.PATH =  vim.fn.stdpath("cache") .. "/nvim-metals:" .. vim.env.PATH
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "scala", "sbt", "java" },
      callback = function() require("metals").initialize_or_attach(require("astronvim.utils.lsp").config("metals")) end,
      group = vim.api.nvim_create_augroup("nvim-metals", { clear = true }),
    })
  end,
}
