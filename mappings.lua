-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)

local is_available = require("astronvim.utils").is_available
local buffer_picker = require("astronvim.utils.status").heirline.buffer_picker
local buffer_closer = require("astronvim.utils.buffer").close
local notify = require("astronvim.utils").notify
local toggle_term_cmd = require("astronvim.utils").toggle_term_cmd
local maps = { n = {}, c = {}, i = {}, v = {}, t = {}, x = {}, o = {} }

-- disbale defaults:
-- Makes more sense to use "\" as vert split and "|" as split, because I use vert split more often
maps.n["<leader>bb"] = false
maps.n["<leader>bd"] = false
maps.n["L"] = {
  function()
    require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1)
  end,
  desc = "Next buffer",
}
maps.n["H"] = {
  function()
    require("astronvim.utils.buffer").nav(
      -(vim.v.count > 0 and vim.v.count or 1)
    )
  end,
  desc = "Previous buffer",
}
--]

--[ register + clipboard
for _, mode in ipairs { "n", "x" } do
  maps[mode]["gy"] = { '"+y', desc = "yank +clipboard" }
  maps[mode]["gY"] = { '"+y$', desc = "Yank +clipboard (y$)" }
  maps[mode]["gD"] = { '"_d', desc = "Delete noregister" }
end
maps.x["p"] = { "P", desc = "Paste noregister" }
--]

maps.n["<leader>."] = { ":tcd %:p:h<CR>", desc = "CD to current file" }
maps.n["<leader>ln"] = { "<CMD>NullLsRestart<CR>", desc = "Null-ls restart" }
maps.n["<leader>F"] = {
  ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>",
  desc = "Find and replace",
}
maps.x["<leader>F"] = {
  '<Esc>"fyiw<CR>gv:s/<C-r>f/<C-r>f/g<Left><Left>',
  desc = "Find and replace visual",
}
maps.n["<C-d>"] = { "<C-d>zz", desc = "Scroll half page down" }
maps.n["<C-u>"] = { "<C-u>zz", desc = "Scroll half page up" }
maps.n["<leader>w"] = { "<CMD>w<CR><ESC>", desc = "Save" }
maps.v["<"] = { "<gv", desc = "Deindent line" }
maps.v[">"] = { ">gv", desc = "Indent line" }

--[ Move cursor with CTRL in insert, command modes
maps.c["<C-h>"] = { "<Left>", desc = "Left" }
maps.c["<C-j>"] = { "<Down>", desc = "Down" }
maps.c["<C-k>"] = { "<Up>", desc = "Up" }
maps.c["<C-l>"] = { "<Right>", desc = "Right" }
maps.i["<C-h>"] = { "<Left>", desc = "Left" }
maps.i["<C-j>"] = { "<Down>", desc = "Down" }
maps.i["<C-k>"] = { "<Up>", desc = "Up" }
maps.i["<C-l>"] = { "<Right>", desc = "Right" }
--]

--[ Better ^ and $
maps.n["gh"] = { "^", desc = "go to beginning of the line (^)" }
maps.n["gl"] = { "$", desc = "go to end of the line ($)" }
maps.x["gh"] = { "^", desc = "go to beginning of the line (^)" }
maps.x["gl"] = { "$", desc = "go to end of the line ($)" }
--]

--[ Better gg and G
maps.n["gj"] = { "G", desc = "go to last line" }
maps.n["gk"] = { "gg", desc = "go to first line" }
maps.x["gj"] = { "G", desc = "go to last line" }
maps.x["gk"] = { "gg", desc = "go to first line" }
--]

--[ buf keymaps
maps.n["<leader>bl"] = {
  function()
    astronvim.move_buf(vim.v.count > 0 and vim.v.count or 1)
  end,
  desc = "Move buffer tab right",
}

if is_available("nvim-notify") then
  maps.n["<leader>uD"] = {
    function()
      require("notify").dismiss { silent = true }
    end,
    desc = "Dismiss notification",
  }
end

if is_available("telescope.nvim") then
  maps.n["<leader>fg"] = {
    require("telescope.builtin").git_files,
    desc = "Find git files",
  }
  maps.n["<leader>fs"] = {
    require("telescope.builtin").spell_suggest,
    desc = "Show spell suggestions",
  }
  local telescope_undo_available, _ = pcall(require, "telescope-undo")
  if telescope_undo_available then
    maps.n["<leader>fu"] = {
      require("telescope").extensions.undo.undo,
      desc = "Show undo history",
    }
  end
end

maps.n["<leader>bh"] = {
  function()
    astronvim.move_buf(-(vim.v.count > 0 and vim.v.count or 1))
  end,
  desc = "Move buffer tab left",
}

maps.n["<leader>bj"] = {
  function()
    buffer_picker(function(bufnr)
      vim.api.nvim_win_set_buf(0, bufnr)
    end)
  end,
  desc = "Jump to buffer from tabline",
}

maps.n["<leader>bc"] = {
  function()
    buffer_picker(function(bufnr)
      buffer_closer(bufnr)
    end)
  end,
  desc = "Close buffer from tabline",
}

maps.n["<leader>bv"] = {
  function()
    buffer_picker(function(bufnr)
      local filename = vim.api.nvim_buf_get_name(bufnr)
      vim.cmd("vertical diffsplit " .. filename)
    end)
  end,
  desc = "Vertical file diff pick buffer",
}

maps.n["<leader>bs"] = {
  function()
    buffer_picker(function(bufnr)
      local filename = vim.api.nvim_buf_get_name(bufnr)
      vim.cmd("diffsplit " .. filename)
    end)
  end,
  desc = "Horisontal file diff pick buffer",
}
--]

--[ ToggleTerm
if is_available("toggleterm.nvim") then
  maps.n["<leader>th"] = {
    "<CMD>ToggleTerm size=15 direction=horizontal<cr>",
    desc = "ToggleTerm horizontal split",
  }
  if vim.fn.executable("lnav") == 1 then
    maps.n["<leader>tL"] = {
      function()
        toggle_term_cmd("lnav " .. vim.fn.expand("%:p"))
      end,
      silent = true,
      desc = "ToggleTerm lnav",
    }
  end
end

--]
local function ui_notify(str)
  if vim.g.ui_notifications_enabled then
    notify(str)
  end
end
local function bool2str(bool)
  return bool and "on" or "off"
end
local function toggle_lazyreadraw()
  vim.opt.lazyredraw = not vim.opt.lazyredraw:get()
  ui_notify(("lazy redraw %s"):format(bool2str(vim.opt.lazyredraw:get())))
end

maps.n["<leader>ur"] = {
  toggle_lazyreadraw,
  desc = "Toggle lazyredraw",
}

if is_available("nvim-treesitter-context") then
  maps.n["[c"] = {
    function()
      require("treesitter-context").go_to_context()
    end,
    desc = "Go to context",
  }
end

if is_available("nvim-transparent") then
  maps.n["<leader>uT"] =
    { "<CMD>TransparentToggle<CR>", desc = "Toggle tranparency" }
end

if is_available("refactoring.nvim") then
  maps.x["<leader>r"] = {
    "<Esc><CMD>Refactoring<CR>",
    desc = "Refactoring",
    silent = true,
    expr = false,
  }
end

if is_available("diffview.nvim") then
  maps.n["<leader>gd"] = {
    "<CMD>DiffviewOpen<CR>",
    desc = "Open diff view (g? help)",
    silent = true,
  }
  maps.n["<leader>gC"] = { "<CMD>DiffviewClose<CR>", desc = "Close diff view" }
  maps.n["<leader>gh"] = {
    "<CMD>DiffviewFileHistory % -f<CR>",
    desc = "Open file history",
    silent = true,
  }
  maps.n["<leader>gH"] = {
    "<CMD>DiffviewFileHistory<CR>",
    desc = "Open branch history",
    silent = true,
  }
  maps.x["<leader>gh"] =
    { ":DiffviewFileHistory<CR>", desc = "Open line history", silent = true }
end

-- GitSigns
if is_available("gitsigns.nvim") then
  maps.n["<leader>gR"] = {
    function()
      require("gitsigns").reset_buffer()
    end,
    desc = "Reset Git buffer",
  }
  maps.n["<leader>gr"] = {
    function()
      require("gitsigns").reset_hunk()
    end,
    desc = "Reset Git hunk",
  }
  maps.n["<leader>gD"] = {
    require("gitsigns").toggle_deleted,
    desc = "Toggle deleted lines",
  }
end

if is_available("code_runner.nvim") then
  local icon
  if vim.g.icons_enabled then
    icon = "󰐍 "
  else
    icon = ""
  end
  maps.n["<leader>r"] = { desc = icon .. "Code runner" }
  maps.n["<leader>rr"] = { "<CMD>RunCode<CR>", desc = "Run code" }
  maps.n["<leader>rf"] = { "<CMD>RunFile<CR>", desc = "Run file" }
  maps.n["<leader>rt"] = { "<CMD>RunFile tab<CR>", desc = "Run file tab" }
  maps.n["<leader>rc"] = { "<CMD>RunClose<CR>", desc = "Close runner" }
  maps.n["<leader>rp"] =
    { "<CMD>RunFile toggleterm<CR>", desc = "Run file pop up (toggleterm)" }
end

if is_available("neotest") then
  local icon
  if vim.g.icons_enabled then
    icon = " "
  else
    icon = ""
  end
  maps.n["<leader>n"] = { false, desc = icon .. "Neotest" }
  maps.n["<leader>nr"] = { "<CMD>NeotestRun<CR>", desc = "Run nearest test" }
  maps.n["<leader>nf"] =
    { "<CMD>NeotestRunFile<CR>", desc = "Run tests in current file" }
  maps.n["<leader>nS"] = { "<CMD>NeotestStop<CR>", desc = "Stop running test" }
  maps.n["<leader>nd"] =
    { "<CMD>NeotestRunDap<CR>", desc = "Run test in debugger" }
  maps.n["<leader>na"] =
    { "<CMD>NeotestAttach<CR>", desc = "Attach to running test" }
  maps.n["<leader>ns"] =
    { "<CMD>NeotestSummaryToggle<CR>", desc = "Toggle test summary window" }
  maps.n["<leader>no"] =
    { "<CMD>NeotestOutput<CR>", desc = "Show test output" }
  maps.n["<leader>nO"] =
    { "<CMD>NeotestOutputToggle<CR>", desc = "Toggle test output window" }
  maps.n["<leader>nk"] = {
    "<CMD>NeotestJumpPreviousFailed<CR>",
    desc = "Jump to previous failed test",
  }
  maps.n["<leader>nj"] =
    { "<CMD>NeotestJumpNextFailed<CR>", desc = "Jump to next failed test" }
end

maps.n["<leader>rn"] =
  { "<CMD>BetterLuafile<CR>", desc = "Run lua file with nvim-lua" }

if is_available("trouble.nvim") then
  local icon
  if vim.g.icons_enabled then
    icon = "󱠪 "
  else
    icon = ""
  end
  maps.n["<leader>x"] = { desc = icon .. "Trouble" }
  maps.n["<leader>xr"] =
    { "<CMD>Trouble lsp_references<CR>", desc = "References (Trouble)" }
  maps.n["<leader>xf"] =
    { "<CMD>Trouble lsp_definitions<CR>", desc = "Definitions (Trouble)" }
  maps.n["<leader>xq"] =
    { "<CMD>Trouble quickfix<CR>", desc = "QuickFix (Trouble)" }
  maps.n["<leader>xl"] =
    { "<CMD>Trouble loclist<CR>", desc = "LocationList (Trouble)" }
  maps.n["<leader>xt"] = { "<CMD>TodoTrouble<CR>", desc = "TODO list" }
end

if is_available("glow.nvim") then
  local icon
  if vim.g.icons_enabled then
    icon = "󰽛 "
  else
    icon = ""
  end
  maps.n["<leader>m"] = { desc = icon .. "Markdown" }
  maps.n["<leader>mM"] = { "<CMD>Glow<CR>", desc = "Markdown Glow" }
end

if is_available("markdown-preview.nvim") then
  local icon
  if vim.g.icons_enabled then
    icon = "󰽛 "
  else
    icon = ""
  end
  maps.n["<leader>m"] = { desc = icon .. "Markdown" }
  maps.n["<leader>mm"] =
    { "<CMD>MarkdownPreview<CR>", desc = "MarkdownPreview" }
  maps.n["<leader>mt"] =
    { "<CMD>MarkdownPreviewToggle<CR>", desc = "MarkdownPreview Toggle" }
  maps.n["<leader>ms"] =
    { "<CMD>MarkdownPreviewStop<CR>", desc = "MarkdownPreview Stop" }
end

-- Move
if is_available("move.nvim") then
  -- Normal mode
  maps.n["<M-j>"] = { ":MoveLine(1)<CR>", desc = "Move line down" }
  maps.n["<M-k>"] = { ":MoveLine(-1)<CR>", desc = "Move line up" }
  maps.n["<M-h>"] = { ":MoveHChar(-1)<CR>", desc = "Move char left" }
  maps.n["<M-l>"] = { ":MoveHChar(1)<CR>", desc = "Move char right" }
  -- Visual mode
  maps.x["<M-j>"] = { ":MoveBlock(1)<CR>", desc = "Move block down" }
  maps.x["<M-k>"] = { ":MoveBlock(-1)<CR>", desc = "Move block up" }
  maps.x["<M-h>"] = { ":MoveHBlock(-1)<CR>", desc = "Move block left" }
  maps.x["<M-l>"] = { ":MoveHBlock(1)<CR>", desc = "Move block right" }
end

-- Smart Splits (remapped on Meta key)
if is_available("smart-splits.nvim") then
  -- Resize with arrows
  maps.n["<M-Up>"] = {
    function()
      require("smart-splits").resize_up()
    end,
    desc = "Resize split up",
  }
  maps.n["<M-Down>"] = {
    function()
      require("smart-splits").resize_down()
    end,
    desc = "Resize split down",
  }
  maps.n["<M-Left>"] = {
    function()
      require("smart-splits").resize_left()
    end,
    desc = "Resize split left",
  }
  maps.n["<M-Right>"] = {
    function()
      require("smart-splits").resize_right()
    end,
    desc = "Resize split right",
  }
else
  maps.n["<M-Up>"] = { "<CMD>resize -2<CR>", desc = "Resize split up" }
  maps.n["<M-Down>"] = { "<CMD>resize +2<CR>", desc = "Resize split down" }
  maps.n["<M-Left>"] =
    { "<CMD>vertical resize -2<CR>", desc = "Resize split left" }
  maps.n["<M-Right>"] =
    { "<CMD>vertical resize +2<CR>", desc = "Resize split right" }
end

-- add more text objects for "in" and "around"
for _, char in ipairs {
  "_",
  ".",
  ":",
  ",",
  ";",
  "|",
  "/",
  "\\",
  "*",
  "+",
  "%",
  "`",
  "?",
} do
  for _, mode in ipairs { "x", "o" } do
    maps[mode]["i" .. char] = {
      string.format(":<C-u>silent! normal! f%sF%slvt%s<CR>", char, char, char),
      desc = "between " .. char,
    }
    maps[mode]["a" .. char] = {
      string.format(":<C-u>silent! normal! f%sF%svf%s<CR>", char, char, char),
      desc = "around " .. char,
    }
  end
end

return maps
