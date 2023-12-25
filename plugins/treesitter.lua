local is_available = require("astronvim.utils").is_available
return {
  "nvim-treesitter/nvim-treesitter",
  cond = not vim.g.vscode,
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
    opts.auto_install = vim.fn.executable("tree-sitter") == 1
    opts.matchup = { enable = true }
  end,
}
