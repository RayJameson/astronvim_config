---@type LazySpec
return {
  "echasnovski/mini.ai",
  event = { "User AstroFile", "InsertEnter" },
  opts = {
    silent = true,
    search_method = "cover_or_nearest",
    custom_textobjects = {
      b = { { "%b()", "%b[]", "%b{}", "%b<>" }, "^.().*().$" },
    },
  },
}
