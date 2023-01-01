return function(opts)
    local cmp = require("cmp")
    local function fallback_func(func)
        return function(fallback)
            if cmp.visible() then
                cmp[func]()
            else
                fallback()
            end
        end
    end

    local cmd_mappings = cmp.mapping.preset.cmdline {
        ["<C-j>"] = { c = fallback_func("select_next_item") },
        ["<C-k>"] = { c = fallback_func("select_prev_item") },
    }
    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmd_mappings,
        sources = {
            { name = "buffer" },
        },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
        mapping = cmd_mappings,
        sources = cmp.config.sources({
            { name = "path" },
        }, {
            { name = "cmdline" },
        }),
    })

    opts.mapping["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" })
    opts.mapping["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" })
    opts.mapping["<M-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" })
    return opts
end
