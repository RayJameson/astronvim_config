local prefix = "<leader>S"
local maps = { n = {}, x = {} }
local icon = vim.g.icons_enabled and " " or ""
maps.n[prefix] = { desc = icon .. "Snippets" }
maps.x[prefix] = { desc = icon .. "Snippets" }
require("astronvim.utils").set_mappings(maps)
return {
  "chrisgrieser/nvim-scissors",
  dependencies = "nvim-telescope/telescope.nvim",
  opts = {
    snippetDir = (vim.env.XDG_CONFIG_HOME or vim.env.HOME .. "/.config") .. "/astronvim/lua/user/snippets",
    jsonFormatter = vim.fn.executable("jq") == 1 and "jq" or "none",
  },
  keys = {
    { prefix .. "e", function() require("scissors").editSnippet() end, desc = "Edit snippet", mode = { "n" } },
    {
      prefix .. "a",
      function() require("scissors").addNewSnippet() end,
      desc = "Add new snippet",
      mode = { "n", "x" },
    },
  },
}
