local is_available = astronvim.is_available
local keymaps = { n = {}, c = {}, i = {}, v = {}, t = {} }

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

if is_available("diffview.nvim") then
    keymaps.n["<leader>gd"] = { "<cmd>DiffviewOpen<CR>", desc = "Open diff view (g? help)", silent = true }
    keymaps.n["<leader>gc"] = { "<cmd>DiffviewClose<CR>", desc = "Close diff view" }
    keymaps.n["<leader>gh"] = { "<cmd>DiffviewFileHistory %<CR>", desc = "Open file history", silent = true }
    keymaps.n["<leader>gH"] = { "<cmd>DiffviewFileHistory<CR>", desc = "Open branch history", silent = true }
    keymaps.v["<leader>gh"] = { ":DiffviewFileHistory<CR>", desc = "Open line history", silent = true }
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
