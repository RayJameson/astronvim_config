-- Configure require("lazy").setup() options
return {
  defaults = { lazy = true },
  lockfile = "./lazy-lock.json",
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
