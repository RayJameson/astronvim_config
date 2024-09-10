---@type LazySpec
return {
  "Exafunction/codeium.vim",
  cond = not vim.g.vscode,
  event = "LspAttach",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        options = {
          g = {
            codeium_enabled = false,
          },
        },
        mappings = {
          n = {
            ["<Leader>;"] = {
              function()
                -- HACK: initially there is no vim.g.codeium_enabled variable even if Codeium enabled
                if vim.g.codeium_enabled == true or vim.g.codeium_enabled == nil then
                  vim.cmd("CodeiumDisable")
                  vim.notify("Codeium disabled")
                else
                  vim.cmd("CodeiumEnable")
                  vim.notify("Codeium enabled")
                end
              end,
              desc = "Toggle Codeium",
            },
          },
          i = {
            ["<C-g>"] = {
              function() return vim.api.nvim_call_function("codeium#Accept", {}) end,
              desc = "Codeium accept",
              expr = true,
            },
            ["<C-,"] = {
              function() return vim.api.nvim_call_function("codeium#CycleCompletions", { 1 }) end,
              desc = "Codeium next",
              expr = true,
            },
            ["<C-x>"] = {
              function() return vim.api.nvim_call_function("codeium#Clear", {}) end,
              desc = "Codeium clear",
              expr = true,
            },
          },
        },
      },
    },
  },
}
