---@type LazySpec
return {
  "L3MON4D3/LuaSnip",
  optional = true,
  specs = {
    {
      "rafamadriz/friendly-snippets",
      config = function(_, opts)
        if opts then require("luasnip").config.setup(opts) end
        vim.tbl_map(
          function(type) require("luasnip.loaders.from_" .. type).lazy_load() end,
          { "vscode", "snipmate", "lua" }
        )
        local luasnip = require("luasnip")
        luasnip.filetype_extend("lua", { "luadoc" })
        luasnip.filetype_extend("python", { "pydoc" })
        luasnip.filetype_extend("rust", { "rustdoc" })
        luasnip.filetype_extend("typescript", { "tsdoc" })
        luasnip.filetype_extend("javascript", { "jsdoc" })
      end,
    },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        opts.autocmds.LuaSnip = {
          {
            desc = "stop snippets when you leave to normal mode\nhttps://github.com/L3MON4D3/LuaSnip/issues/258",
            event = "ModeChanged",
            pattern = "*",
            callback = function()
              local luasnip = require("luasnip")
              if
                ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
                and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
                and not luasnip.session.jump_active
              then
                luasnip.unlink_current()
              end
            end,
          },
        }
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
