return {
    -- first key is the mode
    n = {
        -- second key is the lefthand side of the map
        -- mappings seen under group name "Buffer"
        -- ["<leader>a"] = {  },
        ["<leader>ll"] = { "<cmd>LinterRestart<CR>", desc = "Linter restart" },
        ["<leader>bb"] = { "<cmd>tabnew<CR>", desc = "New tab" },
        ["<leader>bc"] = { "<cmd>BufferLinePickClose<CR>", desc = "Pick to close" },
        ["<leader>bj"] = { "<cmd>BufferLinePick<CR>", desc = "Pick to jump" },
        ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<CR>", desc = "Sort by tabs" },
        ["<leader>U"] = { "<cmd>UndotreeToggle<CR>", desc = "Undotree toggle" },
        ["<leader>gd"] = { "<cmd>DiffviewOpen<CR>", desc = "Open diff view (g? help)", silent = true },
        ["<leader>gc"] = { "<cmd>DiffviewClose<CR>", desc = "Close diff view" },
        ["<leader>gh"] = { "<cmd>DiffviewFileHistory %<CR>", desc = "Open file history", silent = true },
        ["<leader>gH"] = { "<cmd>DiffviewFileHistory<CR>", desc = "Open branch history", silent = true },
        ["<leader>F"] = { ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>", desc = "Find and replace" },
        ["<C-d>"] = { "<C-d>zz", desc = "Scroll half page down" },
        ["<C-u>"] = { "<C-u>zz", desc = "Scroll half page up" },
        ["<M-j>"] = "<cmd>MoveLine(1)<CR>",
        ["<M-k>"] = "<cmd>MoveLine(-1)<CR>",
        ["<M-h>"] = "<cmd>MoveHChar(-1)<CR>",
        ["<M-l>"] = "<cmd>MoveHChar(1)<CR>",
        ["\\"] = { "<cmd>HopChar1<CR>", desc = "Hop to char" },
        ["|"] = { "<cmd>HopPattern<CR>", desc = "Hop pattern" },
    },
    c = {
        ["<C-h>"] = { "<Left>", desc = "Left" },
        ["<C-j>"] = { "<Down>", desc = "Down" },
        ["<C-k>"] = { "<Up>", desc = "Up" },
        ["<C-l>"] = { "<Right>", desc = "Right" },
    },
    v = {
        ["<leader>F"] = { '<Esc>"fyiw<CR>gv:s/<C-r>f/<C-r>f/g<Left><Left>', desc = "Find and replace visual" },
        ["<leader>gh"] = { ":DiffviewFileHistory<CR>", desc = "Open line history", silent = true },
        ["<M-j>"] = ":MoveBlock(1)<CR>",
        ["<M-k>"] = ":MoveBlock(-1)<CR>",
        ["<M-h>"] = ":MoveHBlock(-1)<CR>",
        ["<M-l>"] = ":MoveHBlock(1)<CR>",
    },
    i = {
        ["<C-h>"] = { "<Left>", desc = "Left" },
        ["<C-j>"] = { "<Down>", desc = "Down" },
        ["<C-k>"] = { "<Up>", desc = "Up" },
        ["<C-l>"] = { "<Right>", desc = "Right" },
    },
}
