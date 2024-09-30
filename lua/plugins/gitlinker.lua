---@type LazySpec
return {
  "linrongbin16/gitlinker.nvim",
  opts = function(_, _)
    return {
      router = {
        browse = {
          ["^github%..*%.com"] = require("gitlinker.routers").github_browse,
        },
        blame = {
          ["^github%..*%.com"] = require("gitlinker.routers").github_blame,
        },
      },
    }
  end,
  cmd = "GitLink",
  keys = function()
    local prefix = "<Leader>g"
    return {
      { prefix .. "o", "<cmd>GitLink!<CR>", desc = "Open git line(s) in web", mode = { "n", "x" } },
      { prefix .. "O", "<cmd>GitLink<CR>", desc = "Copy git line(s) url", mode = { "n", "x" } },
    }
  end,
}
