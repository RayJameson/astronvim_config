return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed =
      require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        "lua",
        "luadoc",
        "python",
        "rust",
        "vim",
        "markdown",
        "make",
        "json",
        "json5",
        "yaml",
        "toml",
        "bash",
        "gitcommit",
        "gitattributes",
        "gitignore",
        "git_config",
        "git_rebase",
      })
  end,
}
