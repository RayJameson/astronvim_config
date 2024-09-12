---@type LazySpec
return {
  "cbochs/grapple.nvim",
  cond = not vim.g.vscode,
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "Grapple" },
  opts = function(_, opts) opts.scope = "git_branch" end,
  specs = {
    {
      "AstroNvim/astroui",
      ---@type AstroUIOpts
      opts = { icons = { Grapple = "󰛢" } },
    },
    {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        if opts.mappings == nil then opts.mappings = {} end
        local maps, prefix = opts.mappings, "<Leader><Leader>" ---@cast maps -nil
        maps.n[prefix] = { desc = require("astroui").get_icon("Grapple", 1, true) .. "Grapple" }
        maps.n[prefix .. "t"] = {
          "<cmd>Grapple toggle<CR>",
          desc = "Toggle a file",
        }
        maps.n[prefix .. "s"] = {
          "<cmd>Grapple toggle_scopes<CR>",
          desc = "Toggle a file",
        }
        maps.n["<C-n>"] = { "<cmd>Grapple cycle forward<CR>", desc = "Select next tag" }
        maps.n["<C-p>"] = { "<cmd>Grapple cycle backward<CR>", desc = "Select previous tag" }
      end,
    },
  },
}
