-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)

return function(maps)
  local is_available = require("astronvim.utils").is_available
  local notify = require("astronvim.utils").notify
  local toggle_term_cmd = require("astronvim.utils").toggle_term_cmd
  -- disbale defaults:
  -- Makes more sense to use "\" as vert split and "|" as split, because I use vert split more often
  maps.n["<leader>bb"] = false
  maps.n["<leader>bd"] = false
  --]

  --[ register + clipboard
  for _, mode in ipairs { "n", "v" } do
    maps[mode]["gy"] = { '"+y', desc = "yank +clipboard" }
    maps[mode]["gY"] = { '"+y$', desc = "Yank +clipboard (y$)" }
    maps[mode]["<M-y>"] = { '"+y', desc = "yank +clipboard" }
    maps[mode]["<M-Y>"] = { '"+y$', desc = "Yank +clipboard (y$)" }
    maps[mode]["<M-c>"] = { '"_d', desc = "Change noregister" }
    maps[mode]["<M-d>"] = { '"_d', desc = "Delete noregister" }
    maps[mode]["<M-p>"] = { "v$p", desc = "Paste over rest of the line" }
  end
  maps.n["gD"] = { '"_d', desc = "Delete noregister" }
  maps.x["gd"] = { '"_d', desc = "Delete noregister" }
  maps.x["p"] = { "P", desc = "Paste noregister" }
  maps.n["S"] = { "0Di", desc = "S+" }
  maps.n["gp"] = { "v$p", desc = "Paste over rest of the line" }
  --]
  -- Repeat macros across visual selection

  maps.v["@"] = {
    ":<C-u>call ExecuteMacroOverVisualRange()<CR>",
    desc = "Repeat macros across visual selection",
    silent = false,
  }

  --[ command window
  maps.n["q:"] = { "q:i", desc = "Command window" }
  maps.n["q/"] = { "q/i", desc = "Command search down window" }
  maps.n["q?"] = { "q?i", desc = "Command search up window" }
  --]

  maps.n["<leader>."] = { ":tcd %:p:h<CR>", desc = "CD to current file" }
  maps.n["<leader>ln"] = { "<CMD>NullLsRestart<CR>", desc = "Null-ls restart" }
  maps.n["<leader>F"] = {
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>",
    desc = "Find and replace",
  }
  maps.v["<leader>F"] = {
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
  maps.v["gh"] = { "^", desc = "go to beginning of the line (^)" }
  maps.v["gl"] = { "$", desc = "go to end of the line ($)" }
  --]

  --[ Better gg and G
  maps.n["gj"] = { "G", desc = "go to last line" }
  maps.n["gk"] = { "gg", desc = "go to first line" }
  maps.v["gj"] = { "G", desc = "go to last line" }
  maps.v["gk"] = { "gg", desc = "go to first line" }
  --]

  if is_available("nvim-notify") then
    maps.n["<leader>uD"] = { function() require("notify").dismiss { silent = true } end, desc = "Dismiss notification" }
  end

  if is_available("orgmode") then
    local icon = vim.g.icons_enabled and " " or ""
    maps.n["<leader>o"] = { desc = icon .. "Orgmode" }
  end

  -- mini.ai
  if is_available("mini.ai") then
    local a_maps = {
      [" "] = "around whitespace",
      ["?"] = "around user prompt",
      _ = "around underscore",
      a = "around argument",
      c = "around class",
      f = "around function",
      k = "around block",
      o = "around conditional or loop",
      q = "around quote `, \", '",
    }
    maps.o = {
      a = a_maps,
      i = vim.tbl_map(function(m) return m:gsub("^around", "inside") end, a_maps),
    }
    maps.x = vim.deepcopy(maps.o)
  end

  if is_available("telescope.nvim") then
    local prefix = "<leader>f"
    maps.n[prefix .. "g"] = { require("telescope.builtin").git_files, desc = "Find git files" }
    maps.n[prefix .. "s"] = { require("telescope.builtin").spell_suggest, desc = "Show spell suggestions" }
    local telescope_undo_available, _ = pcall(require, "telescope-undo")
    if telescope_undo_available then
      maps.n[prefix .. "u"] = { require("telescope").extensions.undo.undo, desc = "Show undo history" }
    end
    local telescope_project_available, _ = pcall(require, "project_nvim")
    if telescope_project_available then
      maps.n[prefix .. "p"] = { require("telescope").extensions.projects.projects, desc = "Find projects" }
    end
  end

  --[ ToggleTerm
  if is_available("toggleterm.nvim") then
    local prefix = "<leader>t"
    maps.n[prefix .. "h"] = { "<CMD>ToggleTerm size=15 direction=horizontal<cr>", desc = "ToggleTerm horizontal split" }
    if vim.fn.executable("lnav") == 1 then
      maps.n[prefix .. "L"] = {
        function() toggle_term_cmd("lnav " .. vim.fn.expand("%:p")) end,
        silent = true,
        desc = "ToggleTerm lnav",
      }
    end
  end

  --]
  local function ui_notify(str)
    if vim.g.ui_notifications_enabled then notify(str) end
  end

  local function bool2str(bool) return bool and "on" or "off" end

  local function toggle_lazyreadraw()
    vim.opt.lazyredraw = not vim.opt.lazyredraw:get()
    ui_notify(("lazy redraw %s"):format(bool2str(vim.opt.lazyredraw:get())))
  end

  maps.n["<leader>ur"] = { toggle_lazyreadraw, desc = "Toggle lazyredraw" }

  if is_available("nvim-treesitter-context") then
    maps.n["[c"] = { function() require("treesitter-context").go_to_context() end, desc = "Go to context" }
  end

  if is_available("nvim-transparent") then
    maps.n["<leader>uT"] = { "<CMD>TransparentToggle<CR>", desc = "Toggle tranparency" }
  end

-- stylua: ignore start
if is_available("nvim-dap") then
  local prefix = "<leader>d"
  maps.n["<F8>"] = { function() require("dap").toggle_breakpoint() end, desc = "Debugger: Toggle Breakpoint", }
  maps.n["<F9>"] = { function() require("dap").step_over() end, desc = "Debugger: Step Over", }
  maps.n["<F10>"] = { function() require("dap").step_into() end, desc = "Debugger: Step Into", }
  maps.n["<F22>"] = { function() require("dap").step_out() end, desc = "Debugger: Step Out", } -- Shift+F10
  maps.n[prefix .. "b"] = { function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint (F8)", }
  maps.n[prefix .. "i"] = { function() require("dap").step_into() end, desc = "Step Into (F10)", }
  maps.n[prefix .. "O"] = { function() require("dap").step_out() end, desc = "Step Out (S-F10)", }
  maps.n[prefix .. "o"] = { function() require("dap").step_over() end, desc = "Step Over (F9)", }
  maps.n["<F11>"] = false
end
  -- stylua: ignore end

  if is_available("diffview.nvim") then
    local prefix = "<leader>g"
    maps.n[prefix .. "d"] = { "<CMD>DiffviewOpen<CR>", desc = "Open diff view (g? help)", silent = true }
    maps.n[prefix .. "C"] = { "<CMD>DiffviewClose<CR>", desc = "Close diff view" }
    maps.n[prefix .. "h"] = { "<CMD>DiffviewFileHistory % -f<CR>", desc = "Open file history", silent = true }
    maps.n[prefix .. "H"] = { "<CMD>DiffviewFileHistory<CR>", desc = "Open branch history", silent = true }
    maps.x[prefix .. "h"] = { ":DiffviewFileHistory<CR>", desc = "Open line history", silent = true }
  end
  -- GitSigns
  if is_available("gitsigns.nvim") then
    local prefix = "<leader>g"
    maps.n[prefix .. "R"] = { function() require("gitsigns").reset_buffer() end, desc = "Reset Git buffer" }
    maps.n[prefix .. "r"] = { function() require("gitsigns").reset_hunk() end, desc = "Reset Git hunk" }
    maps.n[prefix .. "D"] = { require("gitsigns").toggle_deleted, desc = "Toggle deleted lines" }
  end

  if is_available("code_runner.nvim") then
    local icon = vim.g.icons_enabled and "󰐍 " or ""
    local prefix = "<leader>r"
    maps.n[prefix] = { desc = icon .. "Code runner" }
    maps.n[prefix .. "r"] = { "<CMD>RunCode<CR>", desc = "Run code" }
    maps.n[prefix .. "f"] = { "<CMD>RunFile<CR>", desc = "Run file" }
    maps.n[prefix .. "t"] = { "<CMD>RunFile tab<CR>", desc = "Run file tab" }
    maps.n[prefix .. "c"] = { "<CMD>RunClose<CR>", desc = "Close runner" }
    maps.n[prefix .. "p"] = { "<CMD>RunFile toggleterm<CR>", desc = "Run file pop up (toggleterm)" }
  end

  if is_available("sniprun") then
    -- for some reason there is error when using "<CR>" instead of ":"
    for _, mode in pairs { "n", "v" } do
      local icon = vim.g.icons_enabled and " " or ""
      local prefix = "<leader>r"
      if maps[mode][prefix] == nil or maps[mode][prefix].desc == "prefix" then
        maps[mode][prefix] = { desc = icon .. "Snip run" }
      end
      maps[mode][prefix .. "s"] = { ":SnipRun<CR>", desc = "Run snippet" }
      maps[mode][prefix .. "C"] = { ":SnipClose<CR>", desc = "Close SnipRun" }
    end
  end

  if is_available("neotest") then
    local icon = vim.g.icons_enabled and " " or ""
    local prefix = "<leader>n"
    maps.n[prefix] = nil
    maps.n[prefix] = { desc = icon .. "Neotest" }
    maps.n[prefix .. "r"] = { "<CMD>NeotestRun<CR>", desc = "Run nearest test" }
    maps.n[prefix .. "f"] = { "<CMD>NeotestRunFile<CR>", desc = "Run tests in current file" }
    maps.n[prefix .. "S"] = { "<CMD>NeotestStop<CR>", desc = "Stop running test" }
    maps.n[prefix .. "d"] = { "<CMD>NeotestRunDap<CR>", desc = "Run test in debugger" }
    maps.n[prefix .. "a"] = { "<CMD>NeotestAttach<CR>", desc = "Attach to running test" }
    maps.n[prefix .. "s"] = { "<CMD>NeotestSummaryToggle<CR>", desc = "Toggle test summary window" }
    maps.n[prefix .. "o"] = { "<CMD>NeotestOutput<CR>", desc = "Show test output" }
    maps.n[prefix .. "O"] = { "<CMD>NeotestOutputToggle<CR>", desc = "Toggle test output window" }
    maps.n[prefix .. "k"] = { "<CMD>NeotestJumpPreviousFailed<CR>", desc = "Jump to previous failed test" }
    maps.n[prefix .. "j"] = { "<CMD>NeotestJumpNextFailed<CR>", desc = "Jump to next failed test" }
  end

  maps.n["<leader>rn"] = { "<CMD>BetterLuafile<CR>", desc = "Run lua file with nvim-lua" }

  if is_available("trouble.nvim") then
    local icon = vim.g.icons_enabled and "󱍼 " or ""
    local prefix = "<leader>x"
    maps.n[prefix] = { desc = icon .. "Trouble" }
    maps.n[prefix .. "r"] = { "<CMD>Trouble lsp_references<CR>", desc = "References (Trouble)" }
    maps.n[prefix .. "f"] = { "<CMD>Trouble lsp_definitions<CR>", desc = "Definitions (Trouble)" }
    maps.n[prefix .. "q"] = { "<CMD>Trouble quickfix<CR>", desc = "QuickFix (Trouble)" }
    maps.n[prefix .. "l"] = { "<CMD>Trouble loclist<CR>", desc = "LocationList (Trouble)" }
    maps.n[prefix .. "t"] = { "<CMD>TodoTrouble<CR>", desc = "TODO list" }
  end

  if is_available("glow.nvim") then
    local icon = vim.g.icons_enabled and "󰽛 " or ""
    local prefix = "<leader>m"
    maps.n[prefix] = { desc = icon .. "Markdown" }
    maps.n[prefix .. "M"] = { "<CMD>Glow<CR>", desc = "Markdown Glow" }
  end

  if is_available("markdown-preview.nvim") then
    local icon = vim.g.icons_enabled and "󰽛 " or ""
    local prefix = "<leader>m"
    maps.n[prefix] = { desc = icon .. "Markdown" }
    maps.n[prefix .. "m"] = { "<CMD>MarkdownPreview<CR>", desc = "MarkdownPreview" }
    maps.n[prefix .. "t"] = { "<CMD>MarkdownPreviewToggle<CR>", desc = "MarkdownPreview Toggle" }
    maps.n[prefix .. "s"] = { "<CMD>MarkdownPreviewStop<CR>", desc = "MarkdownPreview Stop" }
  end

  -- Move Lines
  maps.n["<M-j>"] = { "<cmd>m .+1<cr>==", desc = "Move down" }
  maps.n["<M-k>"] = { "<cmd>m .-2<cr>==", desc = "Move up" }
  maps.i["<M-j>"] = { "<esc><cmd>m .+1<cr>==gi", desc = "Move down" }
  maps.i["<M-k>"] = { "<esc><cmd>m .-2<cr>==gi", desc = "Move up" }
  maps.x["<M-j>"] = { ":m '>+1<cr>gv=gv", desc = "Move down" }
  maps.x["<M-k>"] = { ":m '<-2<cr>gv=gv", desc = "Move up" }
  maps.t["<esc><esc>"] = { "<c-\\><c-n>", desc = "Enter Normal Mode" }
  -- Smart Splits (remapped on Meta key)
  if is_available("smart-splits.nvim") then
    -- Resize with arrows
    maps.n["<M-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
    maps.n["<M-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
    maps.n["<M-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
    maps.n["<M-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }
  else
    maps.n["<M-Up>"] = { "<CMD>resize -2<CR>", desc = "Resize split up" }
    maps.n["<M-Down>"] = { "<CMD>resize +2<CR>", desc = "Resize split down" }
    maps.n["<M-Left>"] = { "<CMD>vertical resize -2<CR>", desc = "Resize split left" }
    maps.n["<M-Right>"] = { "<CMD>vertical resize +2<CR>", desc = "Resize split right" }
  end

  -- add more text objects for "in" and "around"
  for _, char in ipairs { "_", ".", ":", ",", ";", "|", "/", "\\", "*", "+", "%", "`", "?" } do
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
end
