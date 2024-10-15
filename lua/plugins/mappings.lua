---@type LazySpec
return {
  "AstroNvim/astrocore",
  opts = function(
    _,
    opts --[[@as AstroCoreOpts]]
  )
    local maps = opts.mappings
    local is_available = require("astrocore").is_available
    -- disbale defaults:
    maps.n["<Leader>b"] = false
    for _, char in ipairs { "b", "d", "C", "c", "l", "r", "s", "p", "\\", "|" } do
      maps.n["<Leader>b" .. char] = false
      if char == "s" then
        for _, s_char in ipairs { "e", "i", "m", "p", "r" } do
          maps.n["<Leader>bs" .. s_char] = false
        end
      end
    end
    --]

    --[ jumplist for j/k number jumps
    maps.n["k"] = { "(v:count > 1 ? \"m'\" . v:count : '') . 'k'", silent = true, expr = true }
    maps.n["j"] = { "(v:count > 1 ? \"m'\" . v:count : '') . 'j'", silent = true, expr = true }
    --]

    --[ register + clipboard
    for _, mode in ipairs { "n", "x" } do
      maps[mode]["gy"] = { '"+y', desc = "yank +clipboard" }
      maps[mode]["gY"] = { '"+y$', desc = "Yank +clipboard (y$)" }
    end
    maps.n["gD"] = { '"_d', desc = "Delete noregister" }
    maps.x["gd"] = { '"_d', desc = "Delete noregister" }
    maps.x["gp"] = { "P", desc = "Paste noregister" }
    maps.n["S"] = { "0Di", desc = "S+" }
    --]

    -- Repeat macros across visual selection
    maps.x["@"] = {
      function() return ":norm @" .. vim.fn.getcharstr() .. "<cr>" end,
      desc = "Repeat macros across visual selection",
      silent = false,
      expr = true,
    }

    --[ command window
    maps.n["q:"] = { "q:i", desc = "Command window" }
    maps.n["q/"] = { "q/i", desc = "Command search down window" }
    maps.n["q?"] = { "q?i", desc = "Command search up window" }
    --]

    maps.n["<Leader>,"] = { ":lcd %:p:h<CR>", desc = "lcd to current file's dir" }
    maps.n["<Leader>."] = { ":tcd %:p:h<CR>", desc = "tcd to current file's dir" }
    maps.n["<Leader>F"] = {
      ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>",
      desc = "Find and replace",
    }
    maps.x["<Leader>F"] = {
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

    maps.n["<Leader>C"] = {
      "<Cmd>%bdelete|edit#<Cr>",
      desc = "Close all other buffers",
    }
    maps.n["<Leader>a"] = {
      "<Cmd>%bdelete<Cr>",
      desc = "Close all buffers",
    }
    maps.n["<Leader>c"] = {
      function()
        require("astrocore.buffer").close()
        local bufs = vim.fn.getbufinfo { buflisted = true }
        if is_available("alpha-nvim") and not bufs[2] then
          require("alpha").start(false, require("alpha").default_config)
        end
      end,
      desc = "Close current buffer",
    }

    --]
    local function ui_notify(str)
      if vim.g.ui_notifications_enabled then require("astrocore").notify(str) end
    end

    local function bool2str(bool) return bool and "on" or "off" end

    local function toggle_lazyreadraw()
      vim.opt.lazyredraw = not vim.opt.lazyredraw:get()
      ui_notify(("lazy redraw %s"):format(bool2str(vim.opt.lazyredraw:get())))
    end

    maps.n["<Leader>ur"] = { toggle_lazyreadraw, desc = "Toggle lazyredraw" }

    maps.n["<Leader>rn"] = { "<CMD>BetterLuafile<CR>", desc = "Run lua file with nvim-lua" }

    -- Move Lines
    maps.n["<M-j>"] = { "<cmd>m .+1<cr>==", desc = "Move down" }
    maps.n["<M-k>"] = { "<cmd>m .-2<cr>==", desc = "Move up" }
    maps.i["<M-j>"] = { "<esc><cmd>m .+1<cr>==gi", desc = "Move down" }
    maps.i["<M-k>"] = { "<esc><cmd>m .-2<cr>==gi", desc = "Move up" }
    maps.x["<M-j>"] = { ":m '>+1<cr>gv=gv", desc = "Move down" }
    maps.x["<M-k>"] = { ":m '<-2<cr>gv=gv", desc = "Move up" }
    maps.t["<Esc><Esc>"] = { "<C-\\><C-n>", desc = "Enter Normal Mode" }
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
  end,
}
