local prefix = "<leader><leader>"
local icon = vim.g.icons_enabled and "󱡀 " or ""
local maps = { n = {} }
maps.n[prefix] = { desc = icon .. "Harpoon" }
require("astronvim.utils").set_mappings(maps)
return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = { "Harpoon" },
  opts = {
    global_settings = {
      mark_branch = true,
    },
  },
  keys = {
    {
      prefix .. "a",
      function() require("harpoon.mark").add_file() end,
      desc = "Add file",
    },
    {
      prefix .. "e",
      function() require("harpoon.ui").toggle_quick_menu() end,
      desc = "Toggle quick menu",
    },
    {
      "<C-x>",
      function()
        vim.ui.input({ prompt = "Harpoon mark index: " }, function(input)
          local num = tonumber(input)
          if num then require("harpoon.ui").nav_file(num) end
        end)
      end,
      desc = "Goto index of mark",
    },
    {
      "<C-p>",
      function() require("harpoon.ui").nav_prev() end,
      desc = "Go to previous mark",
    },
    {
      "<C-n>",
      function() require("harpoon.ui").nav_next() end,
      desc = "Go to next mark",
    },
    {
      prefix .. "m",
      "<cmd>Telescope harpoon marks<CR>",
      desc = "Show marks in Telescope",
    },
    {
      prefix .. "t",
      function()
        vim.ui.input({ prompt = "Terminal window number: " }, function(input)
          local num = tonumber(input)
          if num then require("harpoon.term").gotoTerminal(num) end
        end)
      end,
      desc = "Go to terminal window",
    },
  },
}
