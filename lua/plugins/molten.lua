---@type LazySpec
return {
  "benlubas/molten-nvim",
  lazy = false,
  build = ":UpdateRemotePlugins",
  dependencies = {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      if not opts.mappings then opts.mappings = {} end
      local prefix = "<leader>m"

      opts.mappings.n[prefix] = { "<Cmd>MoltenInit<CR>", desc = "Molten" }
      opts.mappings.n[prefix .. "e"] = { "<Cmd>MoltenEvaluateOperator<CR>", desc = "Run operator selection" }
      opts.mappings.n[prefix .. "rl"] = { "<Cmd>MoltenEvaluateLine<CR>", desc = "Evaluate line" }
      opts.mappings.n[prefix .. "rr"] = { "<Cmd>MoltenReevaluateCell<CR>", desc = "Re-evaluate cell" }
      opts.mappings.v[prefix .. "r"] = { ":<C-u>MoltenEvaluateVisual<CR>gv", desc = "Evaluate visual selection" }
    end,
  },
}
