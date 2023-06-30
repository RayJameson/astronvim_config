return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  {
    "simrat39/rust-tools.nvim",
    opts = { tools = { inlay_hints = { auto = false } } },
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
    "joechrisellis/lsp-format-modifications.nvim",
    event = "User Astrofile",
    cmd = "FormatModifications",
  },
  {
    "m-demare/hlargs.nvim",
    event = "LspAttach",
    opts = {
      color = "#FF7A00", --"#ef9062",
      paint_arg_usages = true,
    },
  },
  {
    "Exafunction/codeium.vim",
    event = "LspAttach",
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })
      vim.keymap.set("i", "<C-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true })
      vim.keymap.set("i", "<C-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true })
      vim.keymap.set("i", "<C-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true })
    end,
  },
  {
    "nvim-neotest/neotest",
    config = function()
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message
              :gsub("\n", " ")
              :gsub("\t", " ")
              :gsub("%s+", " ")
              :gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup {
        adapters = {
          require("neotest-go"),
          require("neotest-rust"),
          require("neotest-python"),
        },
        log_level = vim.log.levels.DEBUG,
      }
      vim.api.nvim_create_user_command(
        "NeotestRun",
        require("neotest").run.run,
        {}
      )
      vim.api.nvim_create_user_command("NeotestRunFile", function()
        require("neotest").run.run(vim.fn.expand("%"))
      end, {})
      vim.api.nvim_create_user_command("NeotestRunDap", function()
        require("neotest").run.run { strategy = "dap" }
      end, {})
      vim.api.nvim_create_user_command("NeotestStop", function()
        require("neotest").run.stop()
      end, {})
      vim.api.nvim_create_user_command("NeotestAttach", function()
        require("neotest").run.attach()
      end, {})
      vim.api.nvim_create_user_command("NeotestSummaryToggle", function()
        require("neotest").summary.toggle()
      end, {})
      vim.api.nvim_create_user_command("NeotestOutput", function()
        require("neotest").output.open { enter = true }
      end, {})
      vim.api.nvim_create_user_command("NeotestOutputToggle", function()
        require("neotest").output_panel.toggle()
      end, {})
      vim.api.nvim_create_user_command("NeotestJumpPreviousFailed", function()
        require("neotest").jump.prev { status = "failed" }
      end, {})
      vim.api.nvim_create_user_command("NeotestJumpNextFailed", function()
        require("neotest").jump.next { status = "failed" }
      end, {})
    end,
    ft = { "go", "rust", "python" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-python",
      "rouge8/neotest-rust",
      "antoinemadec/FixCursorHold.nvim",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "User Astrofile",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = true,
  },
  {
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
    ft = "qf",
    opts = {
      preview = {
        winblend = 0,
      },
    },
  },
  {
    "chentoast/marks.nvim",
    lazy = false,
    config = function()
      require("marks").setup {
        -- whether to map keybinds or not. default true
        default_mappings = true,
        -- which builtin marks to show. default {}
        builtin_marks = {},
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher values will have better performance but may cause visual lag,
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- marks.vim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
          sign = "⚑",
          virt_text = "hello world",
          -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
          -- defaults to false.
          annotate = false,
        },
        mappings = {},
      }
    end,
  },
  {
    "echasnovski/mini.surround",
    event = { "User AstroFile", "InsertEnter" },
    version = false,
    config = function()
      require("mini.surround").setup {
        mappings = {
          add = "ys",
          delete = "ds",
          find = "",
          find_left = "",
          highlight = "",
          replace = "cs",
          update_n_lines = "",

          -- Add this only if you don't want to use extended mappings
          suffix_last = "",
          suffix_next = "",
        },
        search_method = "cover_or_next",
      }
      -- Remap adding surrounding to Visual mode selection
      vim.keymap.del("x", "ys")
      vim.keymap.set(
        "x",
        "S",
        [[:<C-u>lua MiniSurround.add('visual')<CR>]],
        { silent = true }
      )
      -- Make special mapping for "add surrounding for line"
      vim.keymap.set("n", "yss", "ys_", { remap = true })
    end,
  },
  {
    "stevearc/oil.nvim",
    config = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "-",
        function()
          return require("oil").open()
        end,
        desc = "Open parent directory",
      },
    },
    init = function()
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        -- Capture the protocol and lazy load oil if it is "oil-ssh", besides also lazy
        -- loading it when the first argument is a directory.
        local adapter = string.match(vim.fn.argv(0), "^([%l-]*)://")
        if (stat and stat.type == "directory") or adapter == "oil-ssh" then
          require("lazy").load { plugins = { "oil.nvim" } }
        end
      end
      if not require("lazy.core.config").plugins["oil.nvim"]._.loaded then
        vim.api.nvim_create_autocmd("BufNew", {
          callback = function()
            if vim.fn.isdirectory(vim.fn.expand("<afile>")) == 1 then
              require("lazy").load { plugins = { "oil.nvim" } }
              -- Once oil is loaded, we can delete this autocmd
              return true
            end
          end,
        })
      end
    end,
    opts = {
      skip_confirm_for_simple_edits = true,
      delete_to_trash = true,
      trash_command = "trash",
      view_options = {
        show_hidden = true,
      },
    },
  },
}
