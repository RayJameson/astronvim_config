vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 100 }
  end,
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
  callback = function()
    vim.api.nvim_win_set_option(0, "foldcolumn", "auto:9")
  end,
})
local function leave_snippet()
  if
    (
      (vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n")
      or vim.v.event.old_mode == "i"
    )
    and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
    and not require("luasnip").session.jump_active
  then
    require("luasnip").unlink_current()
  end
end

-- stop snippets when you leave to normal mode
vim.api.nvim_create_augroup("ModeChangedGroup", { clear = true })
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*",
  group = "ModeChangedGroup",
  callback = function()
    leave_snippet()
  end,
})
