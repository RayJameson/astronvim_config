---@type LazySpec
return {
  "L3MON4D3/LuaSnip",
  cond = not vim.g.vscode,
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      config = function(_, opts)
        if opts then require("luasnip").config.setup(opts) end
        vim.tbl_map(
          function(type) require("luasnip.loaders.from_" .. type).lazy_load() end,
          { "vscode", "snipmate", "lua" }
        )
        require("luasnip").filetype_extend("lua", { "luadoc" })
        require("luasnip").filetype_extend("python", { "pydoc" })
        require("luasnip").filetype_extend("rust", { "rustdoc" })
        require("luasnip").filetype_extend("typescript", { "tsdoc" })
        require("luasnip").filetype_extend("javascript", { "jsdoc" })
      end,
    },
  },
  config = function(plugin, opts)
    require("astronvim.plugins.configs.luasnip")(plugin, opts) -- include the default astronvim config that calls the setup call
    -- add more custom luasnip configuration such as filetype extend or custom snippets
    -- load snippets paths
    require("luasnip.loaders.from_vscode").lazy_load {
      -- this can be used if your configuration lives in ~/.config/nvim
      -- if your configuration lives in ~/.config/astronvim, the full path
      -- must be specified in the next line
      paths = { vim.fn.stdpath("config") .. "/snippets" },
    }
  end,
}
