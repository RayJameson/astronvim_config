return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").setup()
    end,
  },
  {
    "onsails/lspkind.nvim",
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
      return opts
    end,
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    event = "User Astrofile",
  },
  {
    "fedepujol/move.nvim",
    event = "BufRead",
  },
  {
    "CRAG666/code_runner.nvim",
    cmd = { "RunCode", "RunFile" },
    config = function()
      require("code_runner").setup {
        -- put here the commands by filetype
        startinsert = false,
        filetype_path = "", -- No default path define
        project_path = "", -- No default path defined
        filetype = {
          java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
          python = "export PYTHONPATH=$PYTHONPATH:. && time python3 -X dev -u",
          lua = "time luaj",
          typescript = "time deno run",
          rust = "cd $dir && rustc $fileName && time $dir/$fileNameWithoutExt",
          javascript = "time node",
          shellscript = "time bash",
          zsh = "time zsh -i",
          go = "time go run",
          scala = "time scala",
          c = "cd $dir && gcc $fileName -o $fileNameWithoutExt -Wall && time ./$fileNameWithoutExt && rm $fileNameWithoutExt",
          markdown = "rich",
        },
        term = {
          --  Position to open the terminal, this option is ignored if mode is tab
          mode = "toggleterm",
          position = "bot",
          -- position = "vert",
          -- window size, this option is ignored if tab is true
          size = 20,
        },
      }
    end,
  },
  {
    "sindrets/diffview.nvim",
    event = "User AstroGitFile",
    config = function()
      local actions = require("diffview.actions")
      local utils = require("astronvim.utils")
      local prefix = "<leader>D"

      utils.set_mappings {
        n = {
          [prefix] = { name = "Diff View" },
          [prefix .. "<cr>"] = { "<cmd>DiffviewOpen<cr>", desc = "Open DiffView" },
          [prefix .. "h"] = { "<cmd>DiffviewFileHistory %<cr>", desc = "Open DiffView File History" },
          [prefix .. "H"] = { "<cmd>DiffviewFileHistory<cr>", desc = "Open DiffView Branch History" },
        },
      }

      local build_keymaps = function(maps)
        local out = {}
        local i = 1
        for lhs, def in
          pairs(utils.extend_tbl(maps, {
            [prefix .. "q"] = { "<cmd>DiffviewClose<cr>", desc = "Quit Diffview" }, -- Toggle the file panel.
            ["]D"] = { actions.select_next_entry, desc = "Next Difference" }, -- Open the diff for the next file
            ["[D"] = { actions.select_prev_entry, desc = "Previous Difference" }, -- Open the diff for the previous file
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
            if def.mode then
              mode = def.mode
            end
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
            [prefix .. "o"] = { actions.conflict_choose("ours"), desc = "Take Ours" }, -- Choose the OURS version of a conflict
            [prefix .. "t"] = { actions.conflict_choose("theirs"), desc = "Take Theirs" }, -- Choose the THEIRS version of a conflict
            [prefix .. "b"] = { actions.conflict_choose("base"), desc = "Take Base" }, -- Choose the BASE version of a conflict
            [prefix .. "a"] = { actions.conflict_choose("all"), desc = "Take All" }, -- Choose all the versions of a conflict
            [prefix .. "0"] = { actions.conflict_choose("none"), desc = "Take None" }, -- Delete the conflict region
          },
          diff3 = build_keymaps {
            [prefix .. "O"] = { actions.diffget("ours"), mode = { "n", "x" }, desc = "Get Our Diff" }, -- Obtain the diff hunk from the OURS version of the file
            [prefix .. "T"] = { actions.diffget("theirs"), mode = { "n", "x" }, desc = "Get Their Diff" }, -- Obtain the diff hunk from the THEIRS version of the file
          },
          diff4 = build_keymaps {
            [prefix .. "B"] = { actions.diffget("base"), mode = { "n", "x" }, desc = "Get Base Diff" }, -- Obtain the diff hunk from the OURS version of the file
            [prefix .. "O"] = { actions.diffget("ours"), mode = { "n", "x" }, desc = "Get Our Diff" }, -- Obtain the diff hunk from the OURS version of the file
            [prefix .. "T"] = { actions.diffget("theirs"), mode = { "n", "x" }, desc = "Get Their Diff" }, -- Obtain the diff hunk from the THEIRS version of the file
          },
          file_panel = build_keymaps {
            j = actions.next_entry, -- Bring the cursor to the next file entry
            k = actions.prev_entry, -- Bring the cursor to the previous file entry.
            o = actions.select_entry,
            S = actions.stage_all, -- Stage all entries.
            U = actions.unstage_all, -- Unstage all entries.
            X = actions.restore_entry, -- Restore entry to the state on the left side.
            L = actions.open_commit_log, -- Open the commit log panel.
            Cf = { actions.toggle_flatten_dirs, desc = "Flatten" }, -- Flatten empty subdirectories in tree listing style.
            R = actions.refresh_files, -- Update stats and entries in the file list.
            ["-"] = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
            ["<down>"] = actions.next_entry,
            ["<up>"] = actions.prev_entry,
            ["<cr>"] = actions.select_entry, -- Open the diff for the selected entry.
            ["<2-LeftMouse>"] = actions.select_entry,
            ["<c-b>"] = actions.scroll_view(-0.25), -- Scroll the view up
            ["<c-f>"] = actions.scroll_view(0.25), -- Scroll the view down
            ["<tab>"] = actions.select_next_entry,
            ["<s-tab>"] = actions.select_prev_entry,
          },
          file_history_panel = build_keymaps {
            j = actions.next_entry,
            k = actions.prev_entry,
            o = actions.select_entry,
            y = actions.copy_hash, -- Copy the commit hash of the entry under the cursor
            L = actions.open_commit_log,
            zR = { actions.open_all_folds, desc = "Open all folds" },
            zM = { actions.close_all_folds, desc = "Close all folds" },
            ["?"] = { actions.options, desc = "Options" }, -- Open the option panel
            ["<down>"] = actions.next_entry,
            ["<up>"] = actions.prev_entry,
            ["<cr>"] = actions.select_entry,
            ["<2-LeftMouse>"] = actions.select_entry,
            ["<C-A-d>"] = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
            ["<c-b>"] = actions.scroll_view(-0.25),
            ["<c-f>"] = actions.scroll_view(0.25),
            ["<tab>"] = actions.select_next_entry,
            ["<s-tab>"] = actions.select_prev_entry,
          },
          option_panel = {
            q = actions.close,
            o = actions.select_entry,
            ["<cr>"] = actions.select_entry,
            ["<2-LeftMouse"] = actions.select_entry,
          },
        },
      }
    end,
  },
  {
    -- override nvim-cmp plugin
    "hrsh7th/nvim-cmp",
    keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
    dependencies = {
      "hrsh7th/cmp-cmdline", -- add cmp-cmdline as dependency of cmp
    },
    config = function(plugin, opts)
      local cmp = require("cmp")
      -- run cmp setup
      cmp.setup(opts)

      -- configure `cmp-cmdline` as described in their repo: https://github.com/hrsh7th/cmp-cmdline#setup
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
      opts.mapping["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" })
      opts.mapping["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" })
      opts.mapping["<M-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" })
    end,
  },
  {
    "joechrisellis/lsp-format-modifications.nvim",
    event = "User Astrofile",
  },
  {
    "m-demare/hlargs.nvim",
    event = "User Astrofile",
    opts = {
      color = "#FF7A00", --"#ef9062",
      paint_arg_usages = true,
    },
  },
}
