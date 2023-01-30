local is_available = astronvim.is_available
local keymaps = { n = {}, c = {}, i = {}, v = {}, t = {} }

--[ disbale defaults:
-- Makes more sense to use "\" as vert split and "|" as split, because I use vert split more often
keymaps.n["<leader>bb"] = false
keymaps.n["<leader>bd"] = false
--]

--[ register + clipboard
keymaps.n["<leader>y"] = { '"+y', desc = "yank +clipboard" }
keymaps.n["<leader>Y"] = { '"+y$', desc = "Yank +clipboard" }
keymaps.v["<leader>y"] = { '"+y', desc = "yank +clipboard" }
keymaps.v["<leader>Y"] = { '"+y$', desc = "Yank +clipboard" }
keymaps.n["<leader>d"] = { '"_d', desc = "Delete noregister" }
keymaps.v["<leader>d"] = { '"_d', desc = "Delete noregister" }
keymaps.v["<leader>p"] = { '"_dP', desc = "Paste noregister" }
--]

keymaps.n["<leader>."] = { ":tcd %:p:h<CR>", desc = "CD to current file" }
keymaps.n["<leader>ll"] = { "<CMD>NullLsRestart<CR>", desc = "Null-ls restart" }
keymaps.n["<leader>F"] = { ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>", desc = "Find and replace" }
keymaps.v["<leader>F"] = { '<Esc>"fyiw<CR>gv:s/<C-r>f/<C-r>f/g<Left><Left>', desc = "Find and replace visual" }
keymaps.n["<C-d>"] = { "<C-d>zz", desc = "Scroll half page down" }
keymaps.n["<C-u>"] = { "<C-u>zz", desc = "Scroll half page up" }

--[ Move cursor with CTRL in insert, command modes
keymaps.c["<C-h>"] = { "<Left>", desc = "Left" }
keymaps.c["<C-j>"] = { "<Down>", desc = "Down" }
keymaps.c["<C-k>"] = { "<Up>", desc = "Up" }
keymaps.c["<C-l>"] = { "<Right>", desc = "Right" }
keymaps.i["<C-h>"] = { "<Left>", desc = "Left" }
keymaps.i["<C-j>"] = { "<Down>", desc = "Down" }
keymaps.i["<C-k>"] = { "<Up>", desc = "Up" }
keymaps.i["<C-l>"] = { "<Right>", desc = "Right" }
--]

--[ Better ^ and $
keymaps.n["gh"] = { "^", desc = "go to beginning of the line (^)" }
keymaps.n["gl"] = { "$", desc = "go to end of the line ($)" }
keymaps.v["gh"] = { "^", desc = "go to beginning of the line (^)" }
keymaps.v["gl"] = { "$", desc = "go to end of the line ($)" }
--]

--[ buf keymaps
keymaps.n["<leader>bl"] = {
    function()
        astronvim.move_buf(vim.v.count > 0 and vim.v.count or 1)
    end,
    desc = "Move buffer tab right",
}
keymaps.n["<leader>bh"] = {
    function()
        astronvim.move_buf(-(vim.v.count > 0 and vim.v.count or 1))
    end,
    desc = "Move buffer tab left",
}

keymaps.n["<leader>bj"] = {
    function()
        astronvim.status.heirline.buffer_picker(function(bufnr)
            vim.api.nvim_win_set_buf(0, bufnr)
        end)
    end,
    desc = "Jump to buffer from tabline",
}
keymaps.n["<leader>bc"] = {
    function()
        astronvim.status.heirline.buffer_picker(function(bufnr)
            astronvim.close_buf(bufnr)
        end)
    end,
    desc = "Close buffer from tabline",
}
keymaps.n["<leader>bv"] = {
    function()
        astronvim.status.heirline.buffer_picker(function(bufnr)
            local filename = vim.api.nvim_buf_get_name(bufnr)
            vim.cmd("vertical diffsplit " .. filename)
        end)
    end,
    desc = "Vertical file diff pick buffer",
}
keymaps.n["<leader>bs"] = {
    function()
        astronvim.status.heirline.buffer_picker(function(bufnr)
            local filename = vim.api.nvim_buf_get_name(bufnr)
            vim.cmd("diffsplit " .. filename)
        end)
    end,
    desc = "Horisontal file diff pick buffer",
}
--]

--[ Terminal {{{
if is_available("toggleterm.nvim") then
    keymaps.n["<leader>th"] =
        { "<CMD>ToggleTerm size=15 direction=horizontal<cr>", desc = "ToggleTerm horizontal split" }
end
--] }}}
local function ui_notify(str)
    if vim.g.ui_notifications_enabled then
        astronvim.notify(str)
    end
end
local function bool2str(bool)
    return bool and "on" or "off"
end
local function toggle_lazyreadraw()
    vim.opt.lazyredraw = not vim.opt.lazyredraw:get()
    ui_notify(("lazy redraw %s"):format(bool2str(vim.opt.lazyredraw:get())))
end

keymaps.n["<leader>ur"] = {
    function()
        toggle_lazyreadraw()
    end,
    desc = "Toggle lazyredraw",
}

if is_available("mind.nvim") then
    keymaps.n["<leader>Mo"] = { "<CMD>MindOpenMain<CR>", desc = "Open Main" }
    keymaps.n["<leader>Mp"] = { "<CMD>MindOpenProject<CR>", desc = "Open Project" }
    keymaps.n["<leader>Ms"] = { "<CMD>MindOpenSmartProject<CR>", desc = "Open Smart Project" }
    keymaps.n["<leader>Mr"] = { "<CMD>MindReloadState<CR>", desc = "Reload state" }
    keymaps.n["<leader>Mc"] = { "<CMD>MindClose<CR>", desc = "Close" }
end

if is_available("nvim-transparent") then
    keymaps.n["<leader>ut"] = { "<CMD>TransparentToggle<CR>", desc = "Toggle tranparency" }
end

if is_available("refactoring.nvim") then
    keymaps.v["<leader>r"] = { "<Esc><CMD>Refactoring<CR>", desc = "Refactoring", silent = true, expr = false }
end

if is_available("nvim-docs-view") then
    keymaps.n["<leader>lv"] = { "<CMD>DocsViewToggle<CR>", desc = "Toggle docs view" }
end

if is_available("diffview.nvim") then
    keymaps.n["<leader>gd"] = { "<CMD>DiffviewOpen<CR>", desc = "Open diff view (g? help)", silent = true }
    keymaps.n["<leader>gc"] = { "<CMD>DiffviewClose<CR>", desc = "Close diff view" }
    keymaps.n["<leader>gh"] = { "<CMD>DiffviewFileHistory % -f<CR>", desc = "Open file history", silent = true }
    keymaps.n["<leader>gH"] = { "<CMD>DiffviewFileHistory<CR>", desc = "Open branch history", silent = true }
    keymaps.v["<leader>gh"] = { ":DiffviewFileHistory<CR>", desc = "Open line history", silent = true }
end

if is_available("code_runner.nvim") then
    keymaps.n["<leader>rr"] = { "<CMD>RunCode<CR>", desc = "Run code" }
    keymaps.n["<leader>rf"] = { "<CMD>RunFile<CR>", desc = "Run file" }
    keymaps.n["<leader>rt"] = { "<CMD>RunFile tab<CR>", desc = "Run file tab" }
    keymaps.n["<leader>rb"] = { "<CMD>RunFile buf<CR>", desc = "Run file buf" }
    keymaps.n["<leader>rc"] = { "<CMD>RunClose<CR>", desc = "Close runner" }
    keymaps.n["<leader>rp"] = { "<CMD>RunFile toggleterm<CR>", desc = "Run file pop up (toggleterm)" }
end

keymaps.n["<leader>rn"] = { "<CMD>BetterLuafile<CR>", desc = "Run lua file with nvim-lua" }

if is_available("trouble.nvim") then
    keymaps.n["<leader>Tr"] = { "<CMD>Trouble lsp_references<CR>", desc = "References" }
    keymaps.n["<leader>Tf"] = { "<CMD>Trouble lsp_definitions<CR>", desc = "Definitions" }
    keymaps.n["<leader>Td"] = { "<CMD>Trouble document_diagnostics<CR>", desc = "Diagnostics" }
    keymaps.n["<leader>Tq"] = { "<CMD>Trouble quickfix<CR>", desc = "QuickFix" }
    keymaps.n["<leader>Tl"] = { "<CMD>Trouble loclist<CR>", desc = "LocationList" }
    keymaps.n["<leader>Tw"] = { "<CMD>Trouble workspace_diagnostics<CR>", desc = "Wordspace Diagnostics" }
    keymaps.n["<leader>Tt"] = { "<CMD>TodoTrouble<CR>", desc = "TODO list" }
end

if is_available("glow.nvim") then
    keymaps.n["<leader>mM"] = { "<CMD>Glow<CR>", desc = "Markdown Glow" }
end

if is_available("markdown-preview.nvim") then
    keymaps.n["<leader>mm"] = { "<CMD>MarkdownPreview<CR>", desc = "MarkdownPreview" }
    keymaps.n["<leader>mt"] = { "<CMD>MarkdownPreviewToggle<CR>", desc = "MarkdownPreview Toggle" }
    keymaps.n["<leader>ms"] = { "<CMD>MarkdownPreviewStop<CR>", desc = "MarkdownPreview Stop" }
end

if is_available("undotree") then
    keymaps.n["<leader>U"] = { "<CMD>UndotreeToggle<CR>", desc = "Undotree toggle" }
end

if is_available("rnvimr") then
    keymaps.n["<leader>R"] = { "<CMD>RnvimrToggle<CR>", desc = "Toggle Ranger" }
end

if is_available("project.nvim") then
    keymaps.n["<leader>sp"] = { "<CMD>Telescope projects<CR>", desc = "Search projects" }
end

-- Move (remapped on Meta key)
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
    keymaps.n["<M-Up>"] = {
        function()
            require("smart-splits").resize_up()
        end,
        desc = "Resize split up",
    }
    keymaps.n["<M-Down>"] = {
        function()
            require("smart-splits").resize_down()
        end,
        desc = "Resize split down",
    }
    keymaps.n["<M-Left>"] = {
        function()
            require("smart-splits").resize_left()
        end,
        desc = "Resize split left",
    }
    keymaps.n["<M-Right>"] = {
        function()
            require("smart-splits").resize_right()
        end,
        desc = "Resize split right",
    }
else
    keymaps.n["<M-Up>"] = { "<CMD>resize -2<CR>", desc = "Resize split up" }
    keymaps.n["<M-Down>"] = { "<CMD>resize +2<CR>", desc = "Resize split down" }
    keymaps.n["<M-Left>"] = { "<CMD>vertical resize -2<CR>", desc = "Resize split left" }
    keymaps.n["<M-Right>"] = { "<CMD>vertical resize +2<CR>", desc = "Resize split right" }
end

return keymaps
