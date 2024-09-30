---@type LazySpec
return {
  "luckasRanarison/nvim-devdocs",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = {
    "DevdocsFetch",
    "DevdocsInstall",
    "DevdocsUninstall",
    "DevdocsOpen",
    "DevdocsOpenCurrent",
    "DevdocsOpenFloat",
    "DevdocsUpdate",
    "DevdocsUpdateAll",
    "DevdocsOpenCurrentFloat",
  },
  opts = {
    previewer_cmd = vim.fn.executable("glow") == 1 and "glow" or nil,
    cmd_args = { "-s", "dark", "-w", "80" },
    picker_cmd = true,
    picker_cmd_args = { "-s", "dark", "-w", "50" },
    float_win = { -- passed to nvim_open_win(), see :h api-floatwin
      relative = "editor",
      height = 35,
      width = 125,
      border = "rounded",
    },
    after_open = function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", true)
    end,
  },
  specs = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>fd"] = {
            function()
              if vim.bo.ft == "python" then
                local check_version_cmd = [[python -c 'import sys; print(".".join(map(str, sys.version_info[:2])))']]
                local python_version = "python-" .. vim.fn.system(check_version_cmd)
                local cmd = ("DevdocsOpenFloat %s"):format(python_version)
                vim.cmd(cmd)
              else
                vim.cmd("DevdocsOpenCurrentFloat")
              end
            end,
            desc = "Find Devdocs for current ft",
          },
          ["<Leader>fD"] = {
            "<cmd>DevdocsOpenFloat<CR>",
            desc = "Find Devdocs",
          },
        },
      },
    },
  },
}
