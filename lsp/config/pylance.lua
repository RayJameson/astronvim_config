return {
  filetypes = { "python" },
  root_dir = function(...)
    return require("lspconfig.util").root_pattern(unpack {
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
      "pyrightconfig.json",
    })(...)
  end,
  cmd = { "pylance", "--stdio" },
  single_file_support = true,

  settings = {
    python = {
      analysis = {
        diagnosticMode = "workspace",
        -- diagnosticMode = "openFilesOnly",
        typeCheckingMode = "basic",
        autoImportCompletions = true,
        autoFormatStrings = true,
        autoImportUserSymbols = true,
        importFormat = "relative",
        completeFunctionParens = true,
        inlayHints = {
          variableTypes = true,
          functionReturnTypes = true,
          callArgumentNames = true,
          pytestParameters = true,
        },
      },
      pythonPath = vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV .. "/bin/python3",
    },
  },
  docs = {
    package_json = vim.env.MASON .. "/packages/pylance/extension/package.json",
    description = [[
      https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance
      `pylance`, Fast, feature-rich language support for Python
      ]],
  },
}
