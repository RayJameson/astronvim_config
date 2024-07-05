local icon = vim.g.icons_enabled and "󰐍 " or ""
local prefix = "<Leader>r"
local maps = { n = {} }
maps.n[prefix] = { desc = icon .. "󰜎 Code runner" }
require("astrocore").set_mappings(maps)

---@type LazySpec
return {
  "CRAG666/code_runner.nvim",
  cond = not vim.g.vscode,
  cmd = { "RunCode", "RunFile" },
  config = function()
    require("code_runner").setup {
      -- put here the commands by filetype
      startinsert = false,
      filetype_path = "", -- No default path define
      project_path = "", -- No default path defined
      filetype = {
        java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
        python = "export PYTHONPATH=$PYTHONPATH:. && time python3 -X dev -u",
        lua = "time luaj",
        typescript = "time deno run",
        rust = "time cargo run",
        javascript = "time node",
        shellscript = "time bash",
        zsh = "time zsh -i",
        go = "time go run",
        scala = "time scala",
        c = "cd $dir && gcc $fileName -o $fileNameWithoutExt -Wall && time ./$fileNameWithoutExt && rm $fileNameWithoutExt",
        markdown = "rich",
      },
      term = {
        --  Position to open the terminal, this option is ignored if mode is tab
        mode = "toggleterm",
        position = "bot",
        -- position = "vert",
        -- window size, this option is ignored if tab is true
        size = 20,
      },
    }
  end,
  keys = {
    { prefix .. "f", "<CMD>RunFile<CR>", desc = "Run file" },
    { prefix .. "t", "<CMD>RunFile tab<CR>", desc = "Run file tab" },
    { prefix .. "c", "<CMD>RunClose<CR>", desc = "Close runner" },
    { prefix .. "p", "<CMD>RunFile toggleterm<CR>", desc = "Run file pop up (toggleterm)" },
  },
}
