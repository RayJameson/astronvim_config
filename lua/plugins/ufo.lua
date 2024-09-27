---@type LazySpec
return {
  "kevinhwang91/nvim-ufo",
  cond = not vim.g.vscode,
  opts = function(_, opts)
    local handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = (" 󰁂 %d "):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, "MoreMsg" })
      return newVirtText
    end
    opts.fold_virt_text_handler = handler
  end,
  specs = {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        DisableUfoForFt = {
          {
            event = "FileType",
            pattern = {
              "Neogit*",
              "dapui*",
              "aerial",
              "dap-repl",
            },
            desc = "Disable `ufo` folds for certain filetypes",
            callback = function(args)
              require("ufo").detach(args.buf) end,
          },
        },
      },
    },
  },
}
