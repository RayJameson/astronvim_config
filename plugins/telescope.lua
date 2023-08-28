local extend_tbl = require("astronvim.utils").extend_tbl
return {
  "nvim-telescope/telescope.nvim",
  cond = not vim.g.vscode,
  -- the first parameter is the plugin specification
  -- the second is the table of options as set up in Lazy with the `opts` key
  dependencies = { "debugloop/telescope-undo.nvim" },
  opts = function(_, opts)
    opts.extensions = {
      undo = {
        use_custom_command = vim.fn.executable("diff-so-fancy") > 0
            and { "bash", "-c", "echo '$DIFF' | diff-so-fancy" }
          or nil,
        layout_strategy = "vertical",
        layout_config = {
          preview_height = 0.7,
          preview_cutoff = 0.3,
        },
        mappings = {
          i = {
            ["<cr>"] = require("telescope-undo.actions").restore,
            ["<S-cr>"] = require("telescope-undo.actions").yank_additions,
            ["<C-cr>"] = require("telescope-undo.actions").yank_deletions,
          },
          n = {
            ["y"] = require("telescope-undo.actions").yank_additions,
            ["Y"] = require("telescope-undo.actions").yank_deletions,
            ["u"] = require("telescope-undo.actions").restore,
          },
        },
      },
    }
    return opts
  end,
  config = function(plugin, opts)
    -- require telescope and load extensions as necessary
    local telescope = require("telescope")
    -- run the core AstroNvim configuration function with the options table
    require("plugins.configs.telescope")(plugin, opts)
    local actions = require("telescope.actions")
    telescope.load_extension("yank_history")
    telescope.load_extension("undo")

    local trouble = require("trouble")
    -- named function for which-key in telescope help
    local smart_add_to_qf_trouble = function(prompt_bufnr)
      actions.smart_add_to_qflist(prompt_bufnr)
      trouble.open("quickfix")
    end
    local smart_send_to_qf_trouble = function(prompt_bufnr)
      actions.smart_send_to_qflist(prompt_bufnr)
      trouble.open("quickfix")
    end

    for _, mode in ipairs { "i", "n" } do
      opts.defaults.mappings[mode] = extend_tbl(opts.defaults.mappings[mode], {
        ["<C-t>"] = smart_add_to_qf_trouble,
        ["<M-t>"] = smart_send_to_qf_trouble,
        ["<C-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.smart_add_to_loclist + actions.open_loclist,
        ["<M-l>"] = actions.smart_send_to_loclist + actions.open_loclist,
      })
    end
  end,
}
