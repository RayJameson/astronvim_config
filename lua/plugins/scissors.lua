local prefix = "<Leader>S"
local maps = { n = {}, x = {} }
local icon = vim.g.icons_enabled and " " or ""
maps.n[prefix] = { desc = icon .. "Snippets" }
maps.x[prefix] = { desc = icon .. "Snippets" }
require("astrocore").set_mappings(maps)

---@type LazySpec
return {
  "chrisgrieser/nvim-scissors",
  dependencies = "nvim-telescope/telescope.nvim",
  opts = {
    snippetDir = vim.fn.stdpath("config") .. "/snippets",
    jsonFormatter = vim.fn.executable("jq") == 1 and "jq" or "none",
  },
  keys = {
    {
      prefix .. "e",
      function()
        local scissors = require("scissors")
        local _, err = pcall(scissors.editSnippet)
        if err ~= nil then
          if err:find("json could not be read") ~= nil then scissors.addNewSnippet() end
        end
      end,
      desc = "Edit snippet",
      mode = { "n" },
    },
    {
      prefix .. "a",
      function() require("scissors").addNewSnippet() end,
      desc = "Add new snippet",
      mode = { "n", "x" },
    },
  },
}
