return {
  "nvim-telescope/telescope.nvim",
  dependencies = { -- add a new dependency to telescope that is our new plugin
    "debugloop/telescope-undo.nvim",
  },
  -- the first parameter is the plugin specification
  -- the second is the table of options as set up in Lazy with the `opts` key
  config = function(plugin, opts)
    -- run the core AstroNvim configuration function with the options table
    require("plugins.configs.telescope")(plugin, opts)

    -- require telescope and load extensions as necessary
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    telescope.load_extension("undo")
    telescope.load_extension("yank_history")

    local trouble = require("trouble")
    local smart_send_to_qf_trouble = function(prompt_bufnr)
      actions.smart_send_to_qflist(prompt_bufnr)
      trouble.open("quickfix")
    end
    local smart_add_to_qf_trouble = function(prompt_bufnr)
      actions.smart_add_to_qflist(prompt_bufnr)
      trouble.open("quickfix")
    end
    opts.defaults.mappings.i = require("astronvim.utils").extend_tbl(opts.defaults.mappings.i, {
      ["<M-t>"] = smart_send_to_qf_trouble,
      ["<C-t>"] = smart_add_to_qf_trouble,
      ["<C-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
      ["<M-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      ["<C-l>"] = actions.smart_add_to_loclist + actions.open_loclist,
      ["<M-l>"] = actions.smart_send_to_loclist + actions.open_loclist,
    })
    opts.defaults.mappings.n = require("astronvim.utils").extend_tbl(opts.defaults.mappings.n, {
      ["<M-t>"] = smart_send_to_qf_trouble,
      ["<C-t>"] = smart_add_to_qf_trouble,
      ["<C-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
      ["<M-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      ["<C-l>"] = actions.smart_add_to_loclist + actions.open_loclist,
      ["<M-l>"] = actions.smart_send_to_loclist + actions.open_loclist,
    })
  end,
}
