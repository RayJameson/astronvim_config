local extend_tbl = require("astronvim.utils").extend_tbl
local prefix = "<leader>f"

return {
  "nvim-telescope/telescope.nvim",
  cond = not vim.g.vscode,
  -- the first parameter is the plugin specification
  -- the second is the table of options as set up in Lazy with the `opts` key
  dependencies = { "debugloop/telescope-undo.nvim" },
  opts = function(_, opts)
    opts.extensions = {
      undo = {
        use_custom_command = vim.fn.executable("diff-so-fancy") == 1
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
    local utils = require("astronvim.utils")
    local conditional_func = utils.conditional_func
    conditional_func(telescope.load_extension, pcall(require, "yanky.nvim"), "yank_history")
    conditional_func(telescope.load_extension, pcall(require, "telescope-undo"), "undo")

    -- run the core AstroNvim configuration function with the options table
    require("plugins.configs.telescope")(plugin, opts)
    local actions = require("telescope.actions")

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
    local select_one_or_multi = function(prompt_bufnr)
      local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
      local multi = picker:get_multi_selection()
      if not vim.tbl_isempty(multi) then
        require("telescope.actions").close(prompt_bufnr)
        for _, j in pairs(multi) do
          if j.path ~= nil then vim.cmd(string.format("%s %s", "edit", j.path)) end
        end
      else
        require("telescope.actions").select_default(prompt_bufnr)
      end
    end

    for _, mode in ipairs { "i", "n" } do
      opts.defaults.mappings[mode] = extend_tbl(opts.defaults.mappings[mode], {
        ["<C-t>"] = smart_add_to_qf_trouble,
        ["<M-t>"] = smart_send_to_qf_trouble,
        ["<C-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.smart_add_to_loclist + actions.open_loclist,
        ["<M-l>"] = actions.smart_send_to_loclist + actions.open_loclist,
        ["<CR>"] = select_one_or_multi,
      })
    end
  end,
  keys = {
    { prefix .. "u", function() require("telescope").extensions.undo.undo() end, desc = "Show undo history" },
    { prefix .. "s", function() require("telescope.builtin").spell_suggest() end, desc = "Show spell suggestions" },
    { prefix .. "g", function() require("telescope.builtin").git_files() end, desc = "Find git files" },
  },
}
