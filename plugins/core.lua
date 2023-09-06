return {
  -- customize alpha options
  {
    "AstroNvim/astrotheme",
    commit = "7a52efdd9a5bd302445d284a424467f92e4b1d44",
    optional = true,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  {
    "goolord/alpha-nvim",
    enabled = false,
  },
  {
    "window-picker",
    enabled = false,
  },
  {
    "Shatur/neovim-session-manager",
    enabled = false,
  },
  {
    "L3MON4D3/LuaSnip",
    cond = not vim.g.vscode,
    config = function(plugin, opts)
      require("plugins.configs.luasnip")(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      -- load snippets paths
      require("luasnip.loaders.from_vscode").lazy_load {
        -- this can be used if your configuration lives in ~/.config/nvim
        -- if your configuration lives in ~/.config/astronvim, the full path
        -- must be specified in the next line
        paths = { vim.env.XDG_CONFIG_HOME .. "/astronvim/lua/user/snippets" },
      }
    end,
  },
  -- {
  --   "windwp/nvim-autopairs",
  --   config = function(plugin, opts)
  --     require "plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom autopairs configuration such as custom rules
  --     local npairs = require "nvim-autopairs"
  --     local Rule = require "nvim-autopairs.rule"
  --     local cond = require "nvim-autopairs.conds"
  --     npairs.add_rules(
  --       {
  --         Rule("$", "$", { "tex", "latex" })
  --           -- don't add a pair if the next character is %
  --           :with_pair(cond.not_after_regex "%%")
  --           -- don't add a pair if  the previous character is xxx
  --           :with_pair(
  --             cond.not_before_regex("xxx", 3)
  --           )
  --           -- don't move right when repeat character
  --           :with_move(cond.none())
  --           -- don't delete if the next character is xx
  --           :with_del(cond.not_after_regex "xx")
  --           -- disable adding a newline when you press <cr>
  --           :with_cr(cond.none()),
  --       },
  --       -- disable for .vim files, but it work for another filetypes
  --       Rule("a", "a", "-vim")
  --     )
  --   end,
  -- },
  -- By adding to the which-key config and using our helper function you can add more which-key registered bindings
  -- {
  --   "folke/which-key.nvim",
  --   config = function(plugin, opts)
  --     require "plugins.configs.which-key"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- Add bindings which show up as group name
  --     local wk = require "which-key"
  --     wk.register({
  --       b = { name = "Buffer" },
  --     }, { mode = "n", prefix = "<leader>" })
  --   end,
  -- },
  {
    "max397574/better-escape.nvim",
    cond = not vim.g.vscode,
    opts = function(_, opts)
      opts.mapping = { "JK", "JJ", "jk", "jj" }
      opts.keys = function() return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>" end
    end,
  },
  {
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
          nvim_lsp = "LSP",
          luasnip = "LuaSnip",
          nvim_lua = "Lua",
          latex_symbols = "Latex",
          orgmode = "Org",
        }
        if entry and entry.source.name == "nvim_lsp" then
          vim_item.menu = ("[%s] - [%s]"):format(sources_map[entry.source.name], entry.source.source.client.name)
        else
          vim_item.menu = ("[%s]"):format(sources_map[entry.source.name])
        end
        return vim_item
      end
      return opts
    end,
  },
  {
    -- override nvim-cmp plugin
    "hrsh7th/nvim-cmp",
    cond = not vim.g.vscode,
    keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
    dependencies = {
      "hrsh7th/cmp-cmdline", -- add cmp-cmdline as dependency of cmp
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      -- configure `cmp-cmdline` as described in their repo: https://github.com/hrsh7th/cmp-cmdline#setup
      opts.sources = cmp.config.sources {
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "orgmode", priority = 650 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
      }
      ---@diagnostic disable-next-line: missing-fields
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      ---@diagnostic disable-next-line: missing-fields
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
      opts.mapping["<M-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" })
      return opts
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    cond = not vim.g.vscode,
    opts = function(_, opts)
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end
      opts.fold_virt_text_handler = handler
    end,
  },
  {
    "mfussenegger/nvim-dap",
    cond = not vim.g.vscode,
    dependencies = { "theHamsta/nvim-dap-virtual-text", config = true },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    cond = not vim.g.vscode,
    opts = function(_, opts) require("astronvim.utils").extend_tbl(opts.filetype_exclude, { "oil" }) end,
  },
}
