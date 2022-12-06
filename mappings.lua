return {
    -- first key is the mode
    n = {
        -- second key is the lefthand side of the map
        -- mappings seen under group name "Buffer"
        ["<C-d>"] = { "<C-d>zz", desc = "Scroll half page down" },
        ["<C-u>"] = { "<c-d>zz", desc = "Scroll half page up" },
        ["<leader>ll"] = { "<cmd>LinterRestart<CR>", desc = "Linter restart" },
        ["<leader>bb"] = { "<cmd>tabnew<CR>", desc = "New tab" },
        ["<leader>bc"] = { "<cmd>BufferLinePickClose<CR>", desc = "Pick to close" },
        ["<leader>bj"] = { "<cmd>BufferLinePick<CR>", desc = "Pick to jump" },
        ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<CR>", desc = "Sort by tabs" },
        ["<A-j>"] = "<cmd>MoveLine(1)<CR>",
        ["<A-k>"] = "<cmd>MoveLine(-1)<CR>",
        ["<A-h>"] = "<cmd>MoveHChar(-1)<CR>",
        ["<A-l>"] = "<cmd>MoveHChar(1)<CR>",
        ["<leader>F"] = { ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>", desc = "Find and replace" },
        ["\\"] = { "<cmd>HopChar1<CR>", desc = "Hop to char" },
        ["|"] = { "<cmd>HopPattern<CR>", desc = "Hop pattern" },
        ["<leader>U"] = { "<cmd>UndotreeToggle<CR>", desc = "Undotree toggle" },
        ["<leader>gd"] = { "<cmd>DiffviewOpen<CR>", desc = "Open diff view (g? help)", silent = true },
        ["<leader>gc"] = { "<cmd>DiffviewClose<CR>", desc = "Close diff view" },
        ["<leader>gh"] = { "<cmd>DiffviewFileHistory %<CR>", desc = "Open file history", silent = true },
        ["<leader>gH"] = { "<cmd>DiffviewFileHistory<CR>", desc = "Open branch history", silent = true },
    },
    c = {
        ["<C-h>"] = { "<Left>", desc = "Left" },
        ["<C-j>"] = { "<Down>", desc = "Down" },
        ["<C-k>"] = { "<Up>", desc = "Up" },
        ["<C-l>"] = { "<Right>", desc = "Right" },
    },
    v = {
        ["<leader>F"] = { '<Esc>"fyiw<CR>gv:s/<C-r>f/<C-r>f/g<Left><Left>', desc = "Find and replace visual" },
        ["<A-j>"] = ":MoveBlock(1)<CR>",
        ["<A-k>"] = ":MoveBlock(-1)<CR>",
        ["<A-h>"] = ":MoveHBlock(-1)<CR>",
        ["<A-l>"] = ":MoveHBlock(1)<CR>",
        ["<leader>gh"] = { ":DiffviewFileHistory<CR>", desc = "Open line history", silent = true },
    },
    i = {
        ["<C-h>"] = { "<Left>", desc = "Left" },
        ["<C-j>"] = { "<Down>", desc = "Down" },
        ["<C-k>"] = { "<Up>", desc = "Up" },
        ["<C-l>"] = { "<Right>", desc = "Right" },
    },
}
