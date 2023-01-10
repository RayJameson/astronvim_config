return function()
    local codelldb_root = require("mason-core.path").package_prefix("codelldb")
    local codelldb_adapter = codelldb_root .. "/extension/adapter/codelldb"
    local liblldb = codelldb_root .. "/extension/lldb/lib/liblldb.dylib"
    require("rust-tools").setup {
        tools = {
            -- on_initialized = function() require("inlay-hints").set_all() end,
            inlay_hints = { auto = false },
        },
        server = astronvim.lsp.server_settings("rust_analyzer"), -- get the server settings and built in capabilities/on_attach
        dap = {
            adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_adapter, liblldb),
        },
    }
end
