---@type LazySpec
return {
  { import = "plugins.lsp.config" },
  {
    "AstroNvim/astrolsp",
    opts = function(
      _,
      opts --[[@as AstroLSPOpts]]
    )
      local extend_tbl = require("astrocore").extend_tbl
      local maps = opts.mappings
      maps.n.gy = false
      if maps.n["<Leader>lG"] then maps.n["<Leader>lG"][1] = function() vim.lsp.buf.workspace_symbol() end end
      if require("astrocore").is_available("trouble.nvim") then
        local trouble = require("trouble")
        if maps.n.gd then maps.n.gd[1] = function() trouble.open("lsp_definitions") end end
        if maps.n.gI then maps.n.gI[1] = function() trouble.open("lsp_implementations") end end
        if maps.n.gr then maps.n.gr[1] = function() trouble.open("lsp_references") end end
        if maps.n.gT then maps.n.gT[1] = function() trouble.open("lsp_type_definitions") end end
        if maps.n["<Leader>lR"] then maps.n["<Leader>lR"][1] = function() trouble.open("lsp_references") end end
      else
        if maps.n.gd then maps.n.gd[1] = function() vim.lsp.buf.definition() end end
        if maps.n.gI then maps.n.gI[1] = function() vim.lsp.buf.implementation() end end
        if maps.n.gr then maps.n.gr[1] = function() vim.lsp.buf.references() end end
        if maps.n.gT then maps.n.gT[1] = function() vim.lsp.buf.type_definition() end end
        if maps.n["<Leader>lR"] then maps.n["<Leader>lR"][1] = function() vim.lsp.buf.references() end end
      end
      -- Configuration table of features provided by AstroLSP
      opts.features = extend_tbl(opts.features, {
        autoformat = false, -- enable or disable auto formatting on start
        codelens = true, -- enable/disable codelens refresh on start
        inlay_hints = true, -- enable/disable inlay hints on start
        semantic_tokens = false, -- enable/disable semantic token highlighting
      })
      -- customize lsp formatting options
      opts.formatting.format_on_save = extend_tbl(opts.formatting.format_on_save, {
        -- control auto formatting on save
        enabled = false, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      })
      opts.formatting.disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        "lua_ls",
      }
      opts.formatting.timeout_ms = 1000 -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
      -- enable servers that you already have installed without mason
      opts.servers = {
        "pylance",
      }
      -- customize how language servers are attached
      opts.lsp_handlers ={}
      opts.handlers = {
        metals = false,
        -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
        -- function(server, opts) require("lspconfig")[server].setup(opts) end

        -- the key is the server that is being setup with `lspconfig`
        -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
        -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
      }
      -- Configure buffer local auto commands to add when attaching a language server
      -- autocmds = {
      --   -- first key is the `augroup` to add the auto commands to (:h augroup)
      --   lsp_document_highlight = {
      --     -- Optional condition to create/delete auto command group
      --     -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
      --     -- condition will be resolved for each client on each execution and if it ever fails for all clients,
      --     -- the auto commands will be deleted for that buffer
      --     cond = "textDocument/documentHighlight",
      --     -- cond = function(client, bufnr) return client.name == "lua_ls" end,
      --     -- list of auto commands to set
      --     {
      --       -- events to trigger
      --       event = { "CursorHold", "CursorHoldI" },
      --       -- the rest of the autocmd options (:h nvim_create_autocmd)
      --       desc = "Document Highlighting",
      --       callback = function() vim.lsp.buf.document_highlight() end,
      --     },
      --     {
      --       event = { "CursorMoved", "CursorMovedI", "BufLeave" },
      --       desc = "Document Highlighting Clear",
      --       callback = function() vim.lsp.buf.clear_references() end,
      --     },
      --   },
      -- },
      -- A custom `on_attach` function to be run after the default `on_attach` function
      -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
      opts.on_attach = function(client, bufnr)
        if vim.b[bufnr].large_buf then client.stop() end
        if client.name == "ruff_lsp" then client.server_capabilities.hoverProvider = false end
        -- this would disable semanticTokensProvider for all clients
        -- client.server_capabilities.semanticTokensProvider = nil
      end
    end,
  },
}
