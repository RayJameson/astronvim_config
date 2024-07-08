---@type LazySpec
return {
  -- override nvim-cmp plugin
  "hrsh7th/nvim-cmp",
  cond = not vim.g.vscode,
  keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
  dependencies = {
    "hrsh7th/cmp-cmdline",
  },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local any_word = [[\k\+]]
    local cmp = require("cmp")
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        {
          name = "buffer",
          keyword_length = 4,
          option = { keyword_pattern = any_word },
        },
      },
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        {
          name = "path",
          priority = 300,
        },
        {
          name = "cmdline",
          priority = 750,
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      },
    })
    opts.mapping["<M-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" })
    return opts
  end,
}
