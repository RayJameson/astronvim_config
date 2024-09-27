local is_available = require("astrocore").is_available
if not is_available("yanky.nvim") then
  vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    pattern = "*",
    callback = function() vim.highlight.on_yank { higroup = "IncSearch", timeout = 100 } end,
  })
end

vim.api.nvim_create_augroup("RememberFolds", { clear = true })
vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = ".+",
  callback = vim.cmd.mkview,
  group = "RememberFolds",
})
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = ".+",
  callback = vim.cmd.loadview,
  group = "RememberFolds",
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = "*",
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
  end,
})

vim.api.nvim_create_augroup("relative_number_switch", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  group = "relative_number_switch",
  callback = function()
    if vim.wo.relativenumber then
      vim.wo.relativenumber = false
      vim.w.adaptive_relative_number_state = true
    end
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  group = "relative_number_switch",
  callback = function()
    if vim.w.adaptive_relative_number_state then
      vim.wo.relativenumber = true
      vim.w.adaptive_relative_number_state = nil
    end
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function() vim.api.nvim_win_set_option(0, "foldcolumn", "1") end,
})

-- stop snippets when you leave to normal mode
-- https://github.com/L3MON4D3/LuaSnip/issues/258
if is_available("luasnip") then
  vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    group = vim.api.nvim_create_augroup("ModeChangedGroup", { clear = true }),
    callback = function()
      local luasnip = require("luasnip")
      if
        ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
        and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
        and not luasnip.session.jump_active
      then
        luasnip.unlink_current()
      end
    end,
  })
end

-- remove colorcolumn for qf
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  group = vim.api.nvim_create_augroup("QuickFixGroup", { clear = true }),
  callback = function()
    vim.wo.colorcolumn = ""
    vim.wo.signcolumn = "auto:9"
    vim.wo.relativenumber = true
    vim.wo.list = false
  end,
})

vim.api.nvim_create_augroup("DynamicColorColumn", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  group = "DynamicColorColumn",
  callback = function() vim.wo.colorcolumn = "120" end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "dockerfile", "make" },
  group = "DynamicColorColumn",
  callback = function() vim.wo.colorcolumn = "" end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  group = "DynamicColorColumn",
  callback = function() vim.wo.colorcolumn = "71" end,
})

vim.api.nvim_create_augroup("FileSkeletons", { clear = true })
for file_extension, command in pairs {
  sh = "bash",
  zsh = "zsh",
  fish = "fish",
  ksh = "ksh",
  awk = "awk",
} do
  vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*." .. file_extension,
    group = "FileSkeletons",
    callback = function()
      vim.api.nvim_buf_set_lines(0, 0, 0, true, {
        "#!/usr/bin/env " .. command,
      })
    end,
  })
  vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("HelpPages", {}),
    callback = function(opts)
      if vim.bo[opts.buf].filetype == "help" then vim.cmd.wincmd("T") end
    end,
  })
end
