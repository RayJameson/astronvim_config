return {
  "sindrets/diffview.nvim",
  event = "User AstroGitFile",
  config = function()
    local actions = require("diffview.actions")
    local utils = require("astronvim.utils")
    local prefix = "<leader>D"
    local icon = vim.g.icons_enabled and " " or ""
    utils.set_mappings {
      n = {
        [prefix] = { name = icon .. "Diff View" },
        [prefix .. "<cr>"] = {
          "<cmd>DiffviewOpen<cr>",
          desc = "Open DiffView",
        },
        [prefix .. "h"] = {
          "<cmd>DiffviewFileHistory %<cr>",
          desc = "Open DiffView File History",
        },
        [prefix .. "H"] = {
          "<cmd>DiffviewFileHistory<cr>",
          desc = "Open DiffView Branch History",
        },
      },
      x = {
        [prefix] = { name = icon .. "Diff View" },
        [prefix .. "h"] = {
          ":DiffviewFileHistory<cr>",
          desc = "Open DiffView Line History",
        },
      },
    }

    local build_keymaps = function(maps)
      local out = {}
      local i = 1
      for lhs, def in
        pairs(utils.extend_tbl(maps, {
          [prefix .. "q"] = {
            "<cmd>DiffviewClose<cr>",
            desc = "Quit Diffview",
          }, -- Toggle the file panel.
          ["]D"] = { actions.select_next_entry, desc = "Next Difference" }, -- Open the diff for the next file
          ["[D"] = {
            actions.select_prev_entry,
            desc = "Previous Difference",
          }, -- Open the diff for the previous file
          ["[C"] = { actions.prev_conflict, desc = "Next Conflict" }, -- In the merge_tool: jump to the previous conflict
          ["]C"] = { actions.next_conflict, desc = "Previous Conflict" }, -- In the merge_tool: jump to the next conflict
          ["Cl"] = { actions.cycle_layout, desc = "Cycle Diff Layout" }, -- Cycle through available layouts.
          ["Ct"] = { actions.listing_style, desc = "Cycle Tree Style" }, -- Cycle through available layouts.
          ["<leader>e"] = { actions.toggle_files, desc = "Toggle Explorer" }, -- Toggle the file panel.
          ["<leader>o"] = { actions.focus_files, desc = "Focus Explorer" }, -- Bring focus to the file panel
        }))
      do
        local opts
        local rhs = def
        local mode = { "n" }
        if type(def) == "table" then
          if def.mode then mode = def.mode end
          rhs = def[1]
          def[1] = nil
          def.mode = nil
          opts = def
        end
        out[i] = { mode, lhs, rhs, opts }
        i = i + 1
      end
      return out
    end

    require("diffview").setup {
      view = {
        merge_tool = { layout = "diff3_mixed" },
      },
    }
  end,
}
