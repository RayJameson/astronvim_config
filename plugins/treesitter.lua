return {
  "nvim-treesitter/nvim-treesitter",
  cond = not vim.g.vscode,
  commit = "10dd49958c96f86c8247c715bd20a6681afc1d8b",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.highlight = {
      enable = true,
    }
    opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
      "bash",
      "diff",
      "dockerfile",
      "git_config",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "jq",
      "json",
      "json5",
      "jsonc",
      "lua",
      "luadoc",
      "make",
      "markdown",
      "passwd",
      "python",
      "regex",
      "rst",
      "rust",
      "toml",
      "vim",
      "vimdoc",
      "yaml",
    })
    opts.matchup = { enable = true }
  end,
}
