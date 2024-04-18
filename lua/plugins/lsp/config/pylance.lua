---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    ---@diagnostic disable: missing-fields
    config = {
      pylance = {
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
        before_init = function(_, c) c.settings.python.pythonPath = vim.fn.exepath("python3") end,

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
              useLibraryCodeForTypes = true,
            },
          },
        },
        handlers = {
          ["workspace/executeCommand"] = function(_, result)
            if result and result.label == "Extract Method" then
              vim.ui.input({ prompt = "New name: ", default = result.data.newSymbolName }, function(input)
                if input and #input > 0 then vim.lsp.buf.rename(input) end
              end)
            end
          end,
        },
        commands = {
          PylanceExtractMethod = {
            function()
              local arguments = {
                vim.uri_from_bufnr(0):gsub("file://", ""),
                require("vim.lsp.util").make_given_range_params().range,
              }
              vim.lsp.buf.execute_command { command = "pylance.extractMethod", arguments = arguments }
            end,
            description = "Extract Method",
            range = 2,
          },
          PylanceExtractVariable = {
            function()
              local arguments = {
                vim.uri_from_bufnr(0):gsub("file://", ""),
                require("vim.lsp.util").make_given_range_params().range,
              }
              vim.lsp.buf.execute_command { command = "pylance.extractVariable", arguments = arguments }
            end,
            description = "Extract Variable",
            range = 2,
          },
        },
        docs = {
          package_json = (vim.env.MASON or "") .. "/packages/pylance/extension/package.json",
          description = [[
      https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance
      `pylance`, Fast, feature-rich language support for Python
      ]],
        },
      },
    },
  },
}
