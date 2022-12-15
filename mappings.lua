local is_available = astronvim.is_available
local keymaps = { n = {}, c = {}, i = {}, v = {}, t = {} }

keymaps.n["<leader>y"] = { '"+y', desc = "yank +clipboard" }
keymaps.n["<leader>Y"] = { '"+y$', desc = "Yank +clipboard" }
keymaps.v["<leader>y"] = { '"+y', desc = "yank +clipboard" }
keymaps.v["<leader>Y"] = { '"+y$', desc = "Yank +clipboard" }
keymaps.n["<leader>d"] = { '"_d', desc = "Delete noregister" }
keymaps.v["<leader>d"] = { '"_d', desc = "Delete noregister" }
keymaps.v["<leader>p"] = { '"_dP', desc = "Paste noregister" }
keymaps.n["<leader>."] = { ":cd %:p:h<CR>", desc = "CD to current file" }
keymaps.n["<leader>ll"] = { "<cmd>LinterRestart<CR>", desc = "Linter restart" }
keymaps.n["<leader>bb"] = { "<cmd>tabnew<CR>", desc = "New tab" }
keymaps.n["<leader>bc"] = { "<cmd>BufferLinePickClose<CR>", desc = "Pick to close" }
keymaps.n["<leader>bj"] = { "<cmd>BufferLinePick<CR>", desc = "Pick to jump" }
keymaps.n["<leader>bt"] = { "<cmd>BufferLineSortByTabs<CR>", desc = "Sort by tabs" }
keymaps.n["<leader>F"] = { ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>", desc = "Find and replace" }
keymaps.v["<leader>F"] = { '<Esc>"fyiw<CR>gv:s/<C-r>f/<C-r>f/g<Left><Left>', desc = "Find and replace visual" }
keymaps.n["<C-d>"] = { "<C-d>zz", desc = "Scroll half page down" }
keymaps.n["<C-u>"] = { "<C-u>zz", desc = "Scroll half page up" }
keymaps.c["<C-h>"] = { "<Left>", desc = "Left" }
keymaps.c["<C-j>"] = { "<Down>", desc = "Down" }
keymaps.c["<C-k>"] = { "<Up>", desc = "Up" }
keymaps.c["<C-l>"] = { "<Right>", desc = "Right" }
keymaps.i["<C-h>"] = { "<Left>", desc = "Left" }
keymaps.i["<C-j>"] = { "<Down>", desc = "Down" }
keymaps.i["<C-k>"] = { "<Up>", desc = "Up" }
keymaps.i["<C-l>"] = { "<Right>", desc = "Right" }

if is_available("refactoring.nvim") then
    keymaps.v["<leader>r"] = { "<cmd>Refactoring<CR>", desc = "Refactoring" }
end

if is_available("diffview.nvim") then
    keymaps.n["<leader>gd"] = { "<cmd>DiffviewOpen<CR>", desc = "Open diff view (g? help)", silent = true }
    keymaps.n["<leader>gc"] = { "<cmd>DiffviewClose<CR>", desc = "Close diff view" }
    keymaps.n["<leader>gh"] = { "<cmd>DiffviewFileHistory %<CR>", desc = "Open file history", silent = true }
    keymaps.n["<leader>gH"] = { "<cmd>DiffviewFileHistory<CR>", desc = "Open branch history", silent = true }
    keymaps.v["<leader>gh"] = { ":DiffviewFileHistory<CR>", desc = "Open line history", silent = true }
end

if is_available("code_runner.nvim") then
    keymaps.n["<leader>rr"] = { "<cmd>RunCode<CR>", desc = "Run code" }
    keymaps.n["<leader>rf"] = { "<cmd>RunFile<CR>", desc = "Run file" }
    keymaps.n["<leader>rt"] = { "<cmd>RunFile tab<CR>", desc = "Run file tab" }
    keymaps.n["<leader>rb"] = { "<cmd>RunFile buf<CR>", desc = "Run file buf" }
    keymaps.n["<leader>rc"] = { "<cmd>RunClose<CR>", desc = "Close runner" }
end

if is_available("trouble.nvim") then
    keymaps.n["<leader>Tr"] = { "<cmd>Trouble lsp_references<CR>", desc = "References" }
    keymaps.n["<leader>Tf"] = { "<cmd>Trouble lsp_definitions<CR>", desc = "Definitions" }
    keymaps.n["<leader>Td"] = { "<cmd>Trouble document_diagnostics<CR>", desc = "Diagnostics" }
    keymaps.n["<leader>Tq"] = { "<cmd>Trouble quickfix<CR>", desc = "QuickFix" }
    keymaps.n["<leader>Tl"] = { "<cmd>Trouble loclist<CR>", desc = "LocationList" }
    keymaps.n["<leader>Tw"] = { "<cmd>Trouble workspace_diagnostics<CR>", desc = "Wordspace Diagnostics" }
    keymaps.n["<leader>Tt"] = { "<cmd>TodoTrouble<CR>", desc = "TODO list" }
end

if is_available("glow.nvim") then
    keymaps.n["<leader>mM"] = { "<cmd>Glow<CR>", desc = "Markdown Glow" }
end

if is_available("nvim-dap") then
    keymaps.n["<leader>Db"] = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "Breakpoint (F9)" }
    keymaps.n["<leader>Dc"] = { "<cmd>lua require'dap'.continue()<CR>", desc = "Continue" }
    keymaps.n["<leader>Di"] = { "<cmd>lua require'dap'.step_into()<CR>", desc = "Into" }
    keymaps.n["<leader>Do"] = { "<cmd>lua require'dap'.step_over()<CR>", desc = "Over" }
    keymaps.n["<leader>DO"] = { "<cmd>lua require'dap'.step_out()<CR>", desc = "Out" }
    keymaps.n["<leader>Dr"] = { "<cmd>lua require'dap'.repl.toggle()<CR>", desc = "Repl" }
    keymaps.n["<leader>Dl"] = { "<cmd>lua require'dap'.run_last()<CR>", desc = "Last" }
    keymaps.n["<leader>Du"] = { "<cmd>lua require'dapui'.toggle()<CR>", desc = "UI" }
    keymaps.n["<leader>Dx"] = { "<cmd>lua require'dap'.terminate()<CR>", desc = "Exit" }
end

if is_available("markdown-preview.nvim") then
    keymaps.n["<leader>mm"] = { "<cmd>MarkdownPreview<CR>", desc = "MarkdownPreview" }
    keymaps.n["<leader>mt"] = { "<cmd>MarkdownPreviewToggle<CR>", desc = "MarkdownPreview Toggle" }
    keymaps.n["<leader>ms"] = { "<cmd>MarkdownPreviewStop<CR>", desc = "MarkdownPreview Stop" }
end

if is_available("undotree") then
    keymaps.n["<leader>U"] = { "<cmd>UndotreeToggle<CR>", desc = "Undotree toggle" }
end

if is_available("rnvimr") then
    keymaps.n["<leader>R"] = { "<cmd>RnvimrToggle<CR>", desc = "Toggle Ranger" }
end

if is_available("project.nvim") then
    keymaps.n["<leader>sp"] = { "<cmd>Telescope projects<CR>", desc = "Search projects" }
end

if is_available("move.nvim") then
    -- Normal mode
    keymaps.n["<M-j>"] = { ":MoveLine(1)<CR>", desc = "Move line down" }
    keymaps.n["<M-k>"] = { ":MoveLine(-1)<CR>", desc = "Move line up" }
    keymaps.n["<M-h>"] = { ":MoveHChar(-1)<CR>", desc = "Move char left" }
    keymaps.n["<M-l>"] = { ":MoveHChar(1)<CR>", desc = "Move char right" }
    -- Visual mode
    keymaps.v["<M-j>"] = { ":MoveBlock(1)<CR>", desc = "Move block down" }
    keymaps.v["<M-k>"] = { ":MoveBlock(-1)<CR>", desc = "Move block up" }
    keymaps.v["<M-h>"] = { ":MoveHBlock(-1)<CR>", desc = "Move block left" }
    keymaps.v["<M-l>"] = { ":MoveHBlock(1)<CR>", desc = "Move block right" }
end

-- Smart Splits (remapped on Meta key)
if is_available("smart-splits.nvim") then
    -- Resize with arrows
    keymaps.n["<M-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
    keymaps.n["<M-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
    keymaps.n["<M-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
    keymaps.n["<M-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }
else
    keymaps.n["<M-Up>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" }
    keymaps.n["<M-Down>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" }
    keymaps.n["<M-Left>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" }
    keymaps.n["<M-Right>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" }
end

return keymaps
