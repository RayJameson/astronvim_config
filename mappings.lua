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
  end
  maps.n["gD"] = { '"_d', desc = "Delete noregister" }
  maps.x["gd"] = { '"_d', desc = "Delete noregister" }
  maps.x["gp"] = { "P", desc = "Paste noregister" }
  maps.n["S"] = { "0Di", desc = "S+" }
  --]
  -- Repeat macros across visual selection
  maps.n["<leader>n"] = false

  maps.x["@"] = {
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
  maps.x["<leader>F"] = {
    '<Esc>"fyiw<CR>gv:s/<C-r>f/<C-r>f/g<Left><Left>',
    desc = "Find and replace visual",
  }
  maps.n["<C-d>"] = { "<C-d>zz", desc = "Scroll half page down" }
  maps.n["<C-u>"] = { "<C-u>zz", desc = "Scroll half page up" }
  maps.n["<C-f>"] = { "<C-f>zz", desc = "Scroll page down" }
  maps.n["<C-b>"] = { "<C-b>zz", desc = "Scroll page up" }
  maps.x["<"] = { "<gv", desc = "Deindent line" }
  maps.x[">"] = { ">gv", desc = "Indent line" }

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

  maps.n["<leader>c"] = {
    function()
      require("astronvim.utils.buffer").close()
      local bufs = vim.fn.getbufinfo { buflisted = true }
      if is_available("alpha-nvim") and not bufs[2] then
        require("alpha").start(false, require("alpha").default_config)
      end
    end,
    desc = "Close buffer",
  }

  if is_available("nvim-notify") then
    maps.n["<leader>uD"] =
      { function() require("notify").dismiss { silent = true, pending = true } end, desc = "Dismiss notification" }
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
  local icon = vim.g.icons_enabled and " " or ""
  maps.n[prefix] = { desc = icon .. "Debugger" }
  maps.n["<F8>"] = { function() require("dap").toggle_breakpoint() end, desc = "Debugger: Toggle Breakpoint", }
  maps.n["<F9>"] = { function() require("dap").step_over() end, desc = "Debugger: Step Over", }
  maps.n["<F10>"] = { function() require("dap").step_into() end, desc = "Debugger: Step Into", }
  maps.n["<F22>"] = { function() require("dap").step_out() end, desc = "Debugger: Step Out (S-F10)", } -- Shift+F10
  maps.n[prefix .. "b"] = { function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint (F8)", }
  maps.n[prefix .. "i"] = { function() require("dap").step_into() end, desc = "Step Into (F10)", }
  maps.n[prefix .. "O"] = { function() require("dap").step_out() end, desc = "Step Out (S-F10)", }
  maps.n[prefix .. "o"] = { function() require("dap").step_over() end, desc = "Step Over (F9)", }
  maps.n["<F11>"] = false
end
  -- stylua: ignore end

  -- GitSigns
  if is_available("gitsigns.nvim") then
    local prefix = "<leader>g"
    maps.n[prefix .. "R"] = { function() require("gitsigns").reset_buffer() end, desc = "Reset Git buffer" }
    maps.n[prefix .. "r"] = { function() require("gitsigns").reset_hunk() end, desc = "Reset Git hunk" }
    maps.n[prefix .. "D"] = { function() require("gitsigns").toggle_deleted() end, desc = "Toggle deleted lines" }
  end

  if is_available("sniprun") then
    -- there is error when using "<CR>" instead of ":" for visual mode mappings
    -- https://discord.com/channels/939594913560031363/1144604661693812771/1146789150981365761
    -- https://www.reddit.com/r/neovim/comments/y2h8ps/i_have_a_mapping_for_normal_how_to_make_an/
    for _, mode in pairs { "n", "x" } do
      local icon = vim.g.icons_enabled and " " or ""
      local prefix = "<leader>r"
      if maps[mode][prefix] == nil or maps[mode][prefix].desc == "prefix" then
        maps[mode][prefix] = { desc = icon .. "Snip run" }
      end
    end
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
