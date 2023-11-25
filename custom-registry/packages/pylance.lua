local Pkg = require("mason-core.package")
return Pkg.new {
  name = "pylance",
  desc = [[Fast, feature-rich language support for Python]],
  homepage = "https://github.com/microsoft/pylance",
  languages = { Pkg.Lang.Python },
  categories = { Pkg.Cat.LSP },
  install = function(ctx)
    local script = ("\z
    curl --silent --cookie-jar cookies.txt 'https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance' > /dev/null && \z
    curl --silent 'https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-python/vsextensions/vscode-pylance/%s/vspackage' \z
         --junk-session-cookies --cookie cookies.txt --compressed --output 'pylance.vsix'"):format(
      ctx.requested_version:or_else("latest") -- "2023.10.40"  last known working version
    )
    ctx.receipt:with_primary_source(ctx.receipt.unmanaged)
    ctx.spawn.bash { "-c", script }
    ctx.spawn.unzip { "pylance.vsix" }
    ctx.spawn.rm { "pylance.vsix", "cookies.txt" }
    ctx.spawn.sed {
      "-i",
      [[0,/\(if(\!process\[[^] ]*\]\[[^] ]*\])return\!0x\)1/ s//\10/]],
      "extension/dist/server.bundle.js",
    }
    ctx:link_bin(
      "pylance",
      ctx:write_node_exec_wrapper(
        "pylance",
        require("mason-core.path").concat { "extension", "dist", "server.bundle.js" }
      )
    )
  end,
}
