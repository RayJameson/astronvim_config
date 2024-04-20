---@type LazySpec
return {
  "Exafunction/codeium.vim",
  cond = not vim.g.vscode,
  event = "LspAttach",
  config = function()
      -- stylua: ignore start
      vim.keymap.set("i", "<C-g>", function() return vim.api.nvim_call_function("codeium#Accept", {}) end, { expr = true })
      vim.keymap.set("i", "<C-;>", function() return vim.api.nvim_call_function("codeium#CycleCompletions", {1}) end, { expr = true })
      vim.keymap.set("i", "<C-,>", function() return vim.api.nvim_call_function("codeium#CycleCompletions", {-1}) end, { expr = true })
      vim.keymap.set("i", "<C-x>", function() return vim.api.nvim_call_function("codeium#Clear", {}) end, { expr = true })
    -- stylua: ignore end
    vim.keymap.set("n", "<Leader>;", function()
      -- HACK: initially there is no vim.g.codeium_enabled variable even if Codeium enabled
      if vim.g.codeium_enabled == true or vim.g.codeium_enabled == nil then
        vim.cmd("CodeiumDisable")
      else
        vim.cmd("CodeiumEnable")
      end
    end, { noremap = true, desc = "Toggle Codeium" })
  end,
}
