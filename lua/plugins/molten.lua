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

      opts.mappings.n[prefix] = { desc = "Molten" }
      opts.mappings.n[prefix .. "e"] = { "<Cmd>MoltenEvaluateOperator<CR>", desc = "Run operator selection" }
      opts.mappings.n[prefix .. "l"] = { "<Cmd>MoltenEvaluateLine<CR>", desc = "Evaluate line" }
      opts.mappings.n[prefix .. "<CR>"] = { "<Cmd>noautocmd MoltenEnterOutput<CR>", desc = "Enter output" }
      opts.mappings.n[prefix .. "h"] = { "<Cmd>MoltenHideOutput<CR>", desc = "Hide output" }
      opts.mappings.n[prefix .. "d"] = { "<Cmd>MoltenDelete<CR>", desc = "Delete cell" }
      opts.mappings.n[prefix .. "c"] = { "<Cmd>MoltenReevaluateCell<CR>", desc = "Re-evaluate cell" }

      opts.mappings.x[prefix] = { desc = "Molten" }
      opts.mappings.x[prefix .. "r"] = { ":<C-u>MoltenEvaluateVisual<CR>gv", desc = "Evaluate visual selection" }

      if not opts.options then opts.options = {} end
      opts.options.g.molten_output_virt_lines = true
    end,
  },
}
