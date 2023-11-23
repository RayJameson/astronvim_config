-- Configure require("lazy").setup() options
return {
  defaults = { lazy = true },
  lockfile = (vim.env.XDG_CONFIG_HOME or vim.env.HOME .. "/.config") .. "/astronvim/lua/user/lazy-lock.json",
  performance = {
    rtp = {
      -- customize default disabled vim plugins
      disabled_plugins = {
        "tohtml",
        "gzip",
        "matchit",
        "zipPlugin",
        "netrwPlugin",
        "tarPlugin",
      },
    },
  },
}
