local extend_tbl = require("astrocore").extend_tbl
local prefix = "<Leader>f"

---@type LazySpec
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
    local conditional_func = require("astrocore").conditional_func
    conditional_func(telescope.load_extension, pcall(require, "telescope-undo"), "undo")
    conditional_func(telescope.load_extension, pcall(require, "yaml_schema"), "yaml_schema")
    require("astronvim.plugins.configs.telescope")(plugin, opts)

    local actions = require("telescope.actions")
    local from_entry = require("telescope.from_entry")

    local yank_path = function(modifier)
      return function(prompt_bufnr)
        local entry = require("telescope.actions.state").get_selected_entry()
        local filename = from_entry.path(entry, false, false)
        local name = vim.fn.fnamemodify(filename, modifier)
        vim.fn.setreg('"', name)
        actions.close(prompt_bufnr)
      end
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
        ["<C-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.smart_add_to_loclist + actions.open_loclist,
        ["<M-l>"] = actions.smart_send_to_loclist + actions.open_loclist,
        ["<CR>"] = select_one_or_multi,
        ["<C-y>"] = yank_path(":."),
        ["<C-Y>"] = yank_path(),
      })
    end
  end,
  keys = {
    { prefix .. "u", function() require("telescope").extensions.undo.undo() end, desc = "Show undo history" },
    { prefix .. "s", function() require("telescope.builtin").spell_suggest() end, desc = "Show spell suggestions" },
    { prefix .. "g", function() require("telescope.builtin").git_files() end, desc = "Find git files" },
  },
}
