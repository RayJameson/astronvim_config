return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astronvim.utils").list_insert_unique(
          opts.ensure_installed,
          { "bash", "markdown", "markdown_inline", "regex", "vim" }
        )
      end
    end,
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    init = function() vim.g.lsp_handlers_enabled = false end,
    event = "VeryLazy",
    cond = not vim.g.neovide,
    opts = {
      cmdline = { view = "cmdline" },
      lsp = {
        progress = { enabled = false },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
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
          filter = { event = "msg_show", find = "^%d+ line[s]? yanked$" },
          opts = { skip = true },
        }, -- skip yank notifications
        {
          filter = { event = "msg_show", kind = "search_count" },
          opts = { skip = true },
        },
        {
          filter = { event = "msg_show", find = "Hop 1 char:" },
          opts = { skip = true },
        }, -- skip hop notifications
      },
      presets = { lsp_doc_border = true, long_message_to_split = true },
      popupmenu = { backend = "cmp" },
    },
  },
}
