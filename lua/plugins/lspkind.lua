---@type LazySpec
return {
  "onsails/lspkind.nvim",
  cond = not vim.g.vscode,
  opts = function(_, opts)
    -- use codicons preset
    opts.preset = "codicons"
    -- set some missing symbol types
    opts.symbol_map = {
      Array = "",
      Boolean = "",
      Key = "",
      Namespace = "",
      Null = "",
      Number = "",
      Object = "",
      Package = "",
      String = "",
    }
    opts.mode = "symbol_text"
    --[[
      INFO: AstroNvim sets `menu` to empty table but we need it to be `nil` for `before` function to work
      otherwise `menu` will overwrite everything we set up in `vim_item.menu` of `before` function
      https://github.com/AstroNvim/AstroNvim/blob/nightly/lua/plugins/ui.lua#L45
      https://github.com/onsails/lspkind.nvim/blob/57610d5ab560c073c465d6faf0c19f200cb67e6e/lua/lspkind/init.lua#L195
      --]]
    opts.menu = nil
    opts.before = function(entry, vim_item)
      local sources_map = {
        buffer = "Buffer",
        path = "Path",
        cmdline = "Cmdline",
        nvim_lsp = "LSP",
        luasnip = "LuaSnip",
        nvim_lua = "Lua",
        latex_symbols = "Latex",
        orgmode = "Org",
        noice_popupmenu = "Noice",
      }
      if entry and entry.source.name == "nvim_lsp" then
        vim_item.menu = ("[%s] - [%s]"):format(sources_map[entry.source.name], entry.source.source.client.name)
      elseif sources_map[entry.source.name] then
        vim_item.menu = ("[%s]"):format(sources_map[entry.source.name])
      else
        vim_item.menu = ("[%s]"):format(entry.source.name)
      end
      return vim_item
    end
    return opts
  end,
}
