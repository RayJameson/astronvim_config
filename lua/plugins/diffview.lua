---@type LazySpec
return {
  "sindrets/diffview.nvim",
  event = "User AstroGitFile",
  cmd = {
    "DiffviewOpen",
    "DiffviewFileHistory",
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = { winbar_info = true },
      file_history = { winbar_info = true },
      merge_tool = { layout = "diff3_mixed" },
    },
    keymaps = {
      view = {
        { "n", "q", ":DiffviewClose<CR>", { desc = "Close Diffview" } },
      },
      file_history_panel = {
        { "n", "q", ":DiffviewClose<CR>", { desc = "Close Diffview" } },
      },
      file_panel = {
        { "n", "q", ":DiffviewClose<CR>", { desc = "Close Diffview" } },
      },
    },
    hooks = { diff_buf_read = function(bufnr) vim.b[bufnr].view_activated = false end },
  },
  specs = {
    {
      "AstroNvim/astroui",
      ---@type AstroUIOpts
      opts = { icons = { DiffView = "" } },
    },
    {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        if opts.mappings == nil then opts.mappings = {} end
        local maps, prefix = opts.mappings, "<Leader>D" ---@cast maps -nil
        maps.n[prefix] = { desc = require("astroui").get_icon("DiffView", 1, true) .. "Diff View" }
        maps.n[prefix .. "<CR>"] = {
          "<Cmd>DiffviewOpen<Cr>",
          desc = "Open DiffView",
        }
        maps.n[prefix .. "h"] = {
          "<Cmd>DiffviewFileHistory %<Cr>",
          desc = "Open DiffView File History",
        }
        maps.n[prefix .. "H"] = {
          "<Cmd>DiffviewFileHistory<Cr>",
          desc = "Open DiffView Branch History",
        }

        maps.x[prefix] = { desc = require("astroui").get_icon("DiffView", 1, true) .. "Diff View" }
        maps.x[prefix .. "h"] = {
          ":DiffviewFileHistory %<Cr>",
          desc = "Open DiffView File History",
        }
      end,
    },
  },
}
