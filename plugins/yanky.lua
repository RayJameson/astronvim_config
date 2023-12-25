return {
  "gbprod/yanky.nvim",
  cond = not vim.g.vscode,
  dependencies = { "kkharji/sqlite.lua", enabled = not jit.os:find("Windows") },
  event = "UIEnter",
  opts = function()
    local utils = require("yanky.utils")
    local mapping = require("yanky.telescope.mapping")
    return {
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 100,
      },
      ring = {
        history_length = 1000,
        storage = "sqlite",
        sync_with_numbered_registers = true,
        cancel_event = "update",
        ignore_registers = { "_" },
      },
      system_clipboard = {
        sync_with_ring = false,
      },
      picker = {
        telescope = {
          use_default_mappings = false,
          mappings = {
            default = mapping.put("p"),
            i = {
              ["<c-p>"] = mapping.put("p"),
              ["<c-x>"] = mapping.delete(),
              ["<c-r>"] = mapping.set_register(utils.get_default_register()),
            },
            n = {
              p = mapping.put("p"),
              P = mapping.put("P"),
              d = mapping.delete(),
              r = mapping.set_register(utils.get_default_register()),
            },
          },
        },
      },
    }
  end,
  init = function()
    vim.api.nvim_set_hl(0, "YankyYanked", { link = "IncSearch" })
    vim.api.nvim_set_hl(0, "YankyPut", { link = "IncSearch" })
  end,
  keys = {
    { "y", "<Plug>(YankyYank)", desc = "Yank", mode = { "n", "x" } },
    { "p", "<Plug>(YankyPutAfter)", desc = "Put after", mode = { "n", "x" } },
    { "P", "<Plug>(YankyPutBefore)", desc = "Put before", mode = { "n", "x" } },
    { "gp", "<Plug>(YankyGPutAfter)", desc = "gPut after", mode = { "n", "x" } },
    { "gP", "<Plug>(YankyGPutBefore)", desc = "gPut before", mode = { "n", "x" } },
    { "<M-p>", "<Plug>(YankyPreviousEntry)", desc = "Previous yank", mode = "n" },
    { "<M-n>", "<Plug>(YankyNextEntry)", desc = "Next yank", mode = "n" },
    { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indent after linewise", mode = "n" },
    { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indent before linewise", mode = "n" },
    { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put indent after shift right", mode = "n" },
    { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put indent after shift left", mode = "n" },
    { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after filter", mode = "n" },
    { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before filter", mode = "n" },
    {
      "<leader>fy",
      function() require("telescope").extensions.yank_history.yank_history() end,
      desc = "Yank history",
    },
  },
}
