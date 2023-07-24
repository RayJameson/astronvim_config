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
      keymaps = {
        disable_defaults = true,
        view = build_keymaps {
          [prefix .. "o"] = {
            actions.conflict_choose("ours"),
            desc = "Take Ours",
          }, -- Choose the OURS version of a conflict
          [prefix .. "t"] = {
            actions.conflict_choose("theirs"),
            desc = "Take Theirs",
          }, -- Choose the THEIRS version of a conflict
          [prefix .. "b"] = {
            actions.conflict_choose("base"),
            desc = "Take Base",
          }, -- Choose the BASE version of a conflict
          [prefix .. "a"] = {
            actions.conflict_choose("all"),
            desc = "Take All",
          }, -- Choose all the versions of a conflict
          [prefix .. "0"] = {
            actions.conflict_choose("none"),
            desc = "Take None",
          }, -- Delete the conflict region
        },
        diff3 = build_keymaps {
          [prefix .. "O"] = {
            actions.diffget("ours"),
            mode = { "n", "x" },
            desc = "Get Our Diff",
          }, -- Obtain the diff hunk from the OURS version of the file
          [prefix .. "T"] = {
            actions.diffget("theirs"),
            mode = { "n", "x" },
            desc = "Get Their Diff",
          }, -- Obtain the diff hunk from the THEIRS version of the file
        },
        diff4 = build_keymaps {
          [prefix .. "B"] = {
            actions.diffget("base"),
            mode = { "n", "x" },
            desc = "Get Base Diff",
          }, -- Obtain the diff hunk from the OURS version of the file
          [prefix .. "O"] = {
            actions.diffget("ours"),
            mode = { "n", "x" },
            desc = "Get Our Diff",
          }, -- Obtain the diff hunk from the OURS version of the file
          [prefix .. "T"] = {
            actions.diffget("theirs"),
            mode = { "n", "x" },
            desc = "Get Their Diff",
          }, -- Obtain the diff hunk from the THEIRS version of the file
        },
        file_panel = build_keymaps {
          j = { actions.select_next_entry, desc = "Next entry" },
          k = { actions.select_prev_entry, desc = "Previous entry" },
          o = { actions.select_entry, desc = "Select entry" }, -- Open the diff for the selected entry.
          S = { actions.stage_all, desc = "Stage all entries." },
          U = { actions.unstage_all, desc = "Unstage all entries" },
          X = { actions.restore_entry, desc = "Restore entry to the state on the left side" },
          L = { actions.open_commit_log, desc = "Open the commit log panel" },
          Cf = { actions.toggle_flatten_dirs, desc = "Flatten empty subdirectories" },
          R = { actions.refresh_files, desc = "Update stats and entries in the file list" },
          ["-"] = { actions.toggle_stage_entry, desc = "Stage / unstage the selected entry" },
          ["<down>"] = { actions.select_next_entry, desc = "Next entry" },
          ["<up>"] = { actions.select_prev_entry, desc = "Previous entry" },
          ["<cr>"] = { actions.select_entry, desc = "Select entry" },
          ["<2-LeftMouse>"] = { actions.select_entry, desc = "Select entry" },
          ["<c-b>"] = { actions.scroll_view(-0.25), desc = "Scroll up" },
          ["<c-f>"] = { actions.scroll_view(0.25), desc = "Scroll down" },
          ["<tab>"] = { actions.select_next_entry, desc = "Next entry" },
          ["<s-tab>"] = { actions.select_prev_entry, desc = "Previous entry" },
        },
        file_history_panel = build_keymaps {
          j = { actions.select_next_entry, desc = "Next entry" },
          k = { actions.select_prev_entry, desc = "Previous entry" },
          o = { actions.select_entry, desc = "Select entry" },
          y = { actions.copy_hash, desc = "Copy the commit hash" },
          L = { actions.open_commit_log, desc = "Open commit log" },
          zR = { actions.open_all_folds, desc = "Open all folds" },
          zM = { actions.close_all_folds, desc = "Close all folds" },
          ["?"] = { actions.options, desc = "Options" },
          ["<down>"] = { actions.select_next_entry, desc = "Next entry" },
          ["<up>"] = { actions.select_prev_entry, desc = "Previous entry" },
          ["<cr>"] = { actions.select_entry, desc = "Select entry" },
          ["<2-LeftMouse>"] = { actions.select_entry, desc = "Select entry" },
          ["<C-A-d>"] = { actions.open_in_diffview, desc = "Open in diffview" },
          ["<c-b>"] = { actions.scroll_view(-0.25), desc = "Scroll up" },
          ["<c-f>"] = { actions.scroll_view(0.25), desc = "Scroll down" },
          ["<tab>"] = { actions.select_next_entry, desc = "Next entry" },
          ["<s-tab>"] = { actions.select_prev_entry, desc = "Previous entry" },
        },
        option_panel = {
          q = { actions.close, desc = "Close option panel" },
          o = { actions.select_entry, desc = "Select entry" },
          ["<cr>"] = { actions.select_entry, desc = "Select entry" },
          ["<2-LeftMouse"] = { actions.select_entry, desc = "Select entry" },
        },
      },
    }
  end,
}
