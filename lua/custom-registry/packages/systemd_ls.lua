local Pkg = require("mason-core.package")
local pip3 = require("mason-core.managers.pip3")
return Pkg.new {
  name = "systemd-language-server",
  desc = [[Fast, feature-rich language support for Python]],
  homepage = "https://github.com/psacawa/systemd-language-server",
  languages = { Pkg.Lang.systemd },
  categories = { Pkg.Cat.LSP },
  install = function(ctx)
    -- NOTE: using my fork, opened PR upstream https://github.com/psacawa/systemd-language-server/pull/4
    pip3.install { "git+https://github.com/RayJameson/systemd-language-server.git" }:with_receipt() -- very easy way to install this...
    ctx:link_bin("systemd_ls", "venv/bin/systemd-language-server")

    -- pip3.install { "systemd-language-server" }:with_receipt() -- very easy way to install this...

    -- ctx.receipt:with_primary_source(ctx.receipt.pip3("systemd-language-server")):with_name("systemd_ls")
    -- I will leave this here as a reminder of my attempts before I found mason-core.managers.pip3 ...
    --[[
      ctx.spawn.python3 {
        "-m",
        "venv",
        "--systemd-site-packages",
        "venv",
      }
      ctx.spawn.bash {
        "-c",
        "source venv/bin/activate && pip3 install --disable-pip-version-check systemd-language-server",
      }
      ctx:link_bin("systemd_ls", ".venv/bin/systemd-language-server")
    --]]
  end,
}
