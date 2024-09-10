---@type LazySpec
return {
  {
    "folke/noice.nvim",
    init = function() vim.g.lsp_handlers_enabled = false end,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    cond = not (vim.g.neovide or vim.g.vscode),
    opts = {
      cmdline = { view = "cmdline" },
      presets = { lsp_doc_border = true },
      messages = { view_search = false },
      popupmenu = { enabled = false },
      lsp = {
        progress = { enabled = false },
        hover = { enabled = false },
        signature = { enabled = false },
      },
      routes = {
        {
          filter = { event = "msg_show", find = "%d+L,%s%d+B" },
          opts = { skip = true },
        }, -- skip save notifications
        {
          filter = { event = "msg_show", find = "^%d+ more line[s]?" },
          opts = { skip = true },
        }, -- skip paste notifications
        {
          filter = { event = "msg_show", find = "^%d+ fewer line[s]?" },
          opts = { skip = true },
        }, -- skip delete notifications
        {
          filter = { event = "msg_show", find = "^%d+ line[s]? less" },
          opts = { skip = true },
        }, -- skip delete notifications
        {
          filter = { event = "msg_show", find = "^%d+ change[s]?;" },
          opts = { skip = true },
        }, -- skip delete notifications
        {
          filter = { event = "msg_show", find = "^%d+ line[s]? yanked" },
          opts = { skip = true },
        }, -- skip yank notifications
        {
          filter = { event = "msg_show", kind = "search_count" },
          opts = { skip = true },
        },
        {
          filter = { event = "msg_show", find = "^E486: Pattern not found:" },
          opts = { skip = true },
        },
        { filter = { event = "msg_show", cmdline = "^:lua" }, view = "messages" }, -- send lua output to split
        { filter = { event = "msg_show", cmdline = "^:=" }, view = "messages" }, -- send lua output to split
        { filter = { event = "msg_show", min_height = 20 }, view = "messages" }, -- send long messages to split
      },
    },
    specs = {
      "nvim-treesitter/nvim-treesitter",
      cond = not vim.g.vscode,
      opts = function(_, opts)
        if opts.ensure_installed ~= "all" then
          opts.ensure_installed = require("astrocore").list_insert_unique(
            opts.ensure_installed,
            { "bash", "markdown", "markdown_inline", "regex", "vim" }
          )
        end
      end,
    },
  },
}
