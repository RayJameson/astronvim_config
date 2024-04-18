---@type LazySpec
return {
  {
    "goolord/alpha-nvim",
    enabled = false,
  },
  {
    "s1n7ax/nvim-window-picker",
    enabled = false,
  },
  {
    "s1n7ax/nvim-window-picker",
    enabled = false,
  },
  {
    "stevearc/resession.nvim",
    enabled = false,
  },
  {
    "max397574/better-escape.nvim",
    cond = not vim.g.vscode,
    opts = function(_, opts)
      opts.mapping = { "JK", "JJ", "jk", "jj" }
      opts.keys = function() return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>" end
    end,
  },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
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
  },
  {
    "m-demare/hlargs.nvim",
    cond = not (vim.g.vscode or vim.g.neovide),
    event = "User AstroFile",
    opts = {
      color = "#FF7A00",
      paint_arg_usages = true,
    },
  },
  {
    "Exafunction/codeium.vim",
    cond = not vim.g.vscode,
    event = "LspAttach",
    config = function()
      -- stylua: ignore start
      vim.keymap.set("i", "<C-g>", function() return vim.api.nvim_call_function("codeium#Accept", {}) end, { expr = true })
      vim.keymap.set("i", "<C-;>", function() return vim.api.nvim_call_function("codeium#CycleCompletions", {1}) end, { expr = true })
      vim.keymap.set("i", "<C-,>", function() return vim.api.nvim_call_function("codeium#CycleCompletions", {-1}) end, { expr = true })
      vim.keymap.set("i", "<C-x>", function() return vim.api.nvim_call_function("codeium#Clear", {}) end, { expr = true })
      -- stylua: ignore end
      vim.keymap.set("n", "<Leader>;", function()
        -- HACK: initially there is no vim.g.codeium_enabled variable even if Codeium enabled
        if vim.g.codeium_enabled == true or vim.g.codeium_enabled == nil then
          vim.cmd("CodeiumDisable")
        else
          vim.cmd("CodeiumEnable")
        end
      end, { noremap = true, desc = "Toggle Codeium" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    cond = not vim.g.vscode,
    event = "User Astrofile",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      max_lines = 5,
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {
      aliases = {
        ["b"] = { ")", "}", "]", ">" },
      },
    },
  },
  {
    "echasnovski/mini.ai",
    event = { "User AstroFile", "InsertEnter" },
    opts = {
      silent = true,
      search_method = "cover_or_nearest",
      custom_textobjects = {
        b = { { "%b()", "%b[]", "%b{}", "%b<>" }, "^.().*().$" },
      },
    },
  },
  {
    "linrongbin16/gitlinker.nvim",
    cond = not vim.g.vscode,
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
  },
  {
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
      opts.sources = cmp.config.sources {
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "orgmode", priority = 650 },
      }
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
    event = function() return {} end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    cond = not vim.g.vscode,
    opts = function(_, opts) require("astrocore").extend_tbl(opts.filetype_exclude, { "oil" }) end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },
}
