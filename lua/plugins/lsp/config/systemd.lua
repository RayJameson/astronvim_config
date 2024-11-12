if not vim.fn.executable("systemd_ls") then return {} end
---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@param opts AstroLSPOpts
  opts = function(_, opts)
    opts.servers = opts.servers or {}
    table.insert(opts.servers, "systemd_ls")
    opts.config = require("astrocore").extend_tbl(opts.config or {}, {
      systemd_ls = {
        cmd = { "systemd_ls" },
        filetypes = { "systemd" },
        root_dir = function() return nil end,
        single_file_support = true,
        settings = {},
        docs = {
          description = [[
https://github.com/psacawa/systemd-language-server
Language Server for Systemd unit files.

I tested it with python 3.10.15
3.12.7 didn't work
]],
        },
      },
    })
  end,
}
