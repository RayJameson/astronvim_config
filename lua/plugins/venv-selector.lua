---@type LazySpec
return {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp",
  enabled = vim.fn.executable("fd") == 1 or vim.fn.executable("fdfind") == 1 or vim.fn.executable("fd-find") == 1,
  ft = "python",
  dependencies = {
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>lv"] = { "<Cmd>VenvSelect<CR>", desc = "Select VirtualEnv" },
          },
        },
      },
    },
  },
  opts = {},
  cmd = "VenvSelect",
  specs = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      autocmds = {
        VenvSelector = {
          {
            event = "DirChanged",
            desc = "Disable venv on change dir",
            callback = function()
              local venv_selector = require("venv-selector")
              if not venv_selector.venv() then return end
              venv_selector.deactivate()
              venv_selector.stop_lsp_servers()
            end,
          },
        },
      },
    },
  },
}
