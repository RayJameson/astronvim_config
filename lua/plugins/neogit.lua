return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "AstroNvim/astroui", opts = { icons = { Neogit = "󰰔" } } },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        local prefix = "<Leader>g"
        maps.n[prefix .. "n"] = { "<Cmd>Neogit<CR>", desc = require("astroui").get_icon("Neogit", 1, true) .. "Neogit" }
      end,
    },
  },
  specs = {
    {
      "catppuccin",
      optional = true,
      ---@type CatppuccinOptions
      opts = { integrations = { neogit = true } },
    },
    {
      ---@type AstroCoreOpts
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          NeogitLogRefresh = {
            {
              event = "User",
              pattern = {
                "NeogitCherryPick",
                "NeogitBranchCheckout",
                "NeogitBranchCreated",
                "NeogitBranchDelete",
                "NeogitBranchReset",
                "NeogitBranchRename",
                "NeogitRebase",
                "NeogitReset",
                "NeogitTagCreate",
                "NeogitTagDelete",
                "NeogitCommitComplete",
                "NeogitPushComplete",
                "NeogitPullComplete",
                "NeogitFetchComplete",
              },
              callback = function(args)
                if vim.bo[args.buf].filetype ~= "NeogitLogView" then return end
                vim.fn.feedkeys("q", "n")
                require("neogit").action(
                  "log",
                  "log_current",
                  { "--graph", "--decorate", "--max-count=256", "--topo-order" }
                )()
              end,
            },
          },
        },
      },
    },
  },
  event = "User AstroGitFile",
  opts = function(_, opts)
    local utils = require("astrocore")
    local disable_builtin_notifications = utils.is_available("nvim-notify") or utils.is_available("noice.nvim")

    return utils.extend_tbl(opts, {
      process_spinner = false,
      disable_builtin_notifications = disable_builtin_notifications,
      disable_signs = true,
      graph_style = "unicode",
      telescope_sorter = function()
        if utils.is_available("telescope-fzf-native.nvim") then
          return require("telescope").extensions.fzf.native_fzf_sorter()
        end
      end,
      integrations = { telescope = utils.is_available("telescope.nvim") },
    })
  end,
}
