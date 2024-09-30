---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.highlight = {
      enable = true,
    }
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
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
  end,
}
