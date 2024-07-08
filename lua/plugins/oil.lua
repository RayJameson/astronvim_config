---@type LazySpec
return {
  "stevearc/oil.nvim",
  specs = {
    "nvim-tree/nvim-web-devicons",
    {
      "rebelot/heirline.nvim",
      opts = function(_, opts)
        local status = require("astroui.status")
        local is_oil = function(bufnr) return status.condition.buffer_matches({ filetype = "^oil$" }, bufnr) end
        local disable_winbar_cb = opts.opts.disable_winbar_cb
        opts.opts.disable_winbar_cb = function(args)
          if is_oil(args.buf) then return false end
          return disable_winbar_cb(args)
        end

        if opts.winbar then
          table.insert(opts.winbar, 1, {
            condition = function(self) return is_oil(self.bufnr) end,
            status.component.separated_path {
              padding = { left = 2 },
              max_depth = false,
              suffix = false,
              path_func = function() return require("oil").get_current_dir() end,
            },
          })
        end
      end,
    },
  },
  keys = {
    {
      "-",
      function() return require("oil").open() end,
      desc = "Open parent directory",
    },
  },
  init = function()
    -- yoinked it from this comment
    -- https://github.com/folke/lazy.nvim/issues/533#issuecomment-1489174249
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      -- Capture the protocol and lazy load oil if it is "oil-ssh", besides also lazy
      -- loading it when the first argument is a directory.
      local adapter = string.match(vim.fn.argv(0), "^([%l-]*)://")
      if (stat and stat.type == "directory") or adapter == "oil-ssh" then
        require("lazy").load { plugins = { "oil.nvim" } }
      end
    end
    if not package.loaded["oil"] then
      vim.api.nvim_create_augroup("oil_start", { clear = true })
      vim.api.nvim_create_autocmd("BufNew", {
        group = "oil_start",
        desc = "start oil when editing a directory",
        callback = function()
          if vim.fn.isdirectory(vim.fn.expand("<afile>")) == 1 then
            require("lazy").load { plugins = { "oil.nvim" } }
            -- Once oil is loaded, we can delete this autocmd
            return true
          end
        end,
      })
    end
    vim.api.nvim_create_augroup("oil_settings", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = "oil_settings",
      pattern = "oil",
      desc = "Disable view saving for oil buffers",
      callback = function(args) vim.b[args.buf].view_activated = false end,
    })
    vim.api.nvim_create_autocmd("User", {
      group = "oil_settings",
      pattern = "OilActionsPost",
      desc = "Logic to run after an action in Oil",
      callback = function(args)
        if args.data.err then return end
        for _, action in ipairs(args.data.actions) do
          ---@cast action oil.Action
          if action.type == "delete" then
            ---@cast action oil.DeleteAction
            local _, path = require("oil.util").parse_url(action.url)
            local bufnr = vim.fn.bufnr(path)
            if bufnr ~= -1 then require("astrocore.buffer").wipe(bufnr, true) end
          end
        end
      end,
    })
  end,
  opts = {
    skip_confirm_for_simple_edits = true,
    group = "oil_settings",
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["gx"] = {
        callback = function()
          local oil = require("oil")
          local cwd = oil.get_current_dir()
          local entry = oil.get_cursor_entry()
          if cwd and entry then require("astrocore").system_open(string.format("%s/%s", cwd, entry.name)) end
        end,
        desc = "Open file under cursor",
        nowait = true,
      },
      ["gy"] = {
        desc = "Copy the filepath of the entry under the cursor to the + register",
        callback = function()
          local oil = require("oil")
          local entry = oil.get_cursor_entry()
          local dir = oil.get_current_dir()
          if not entry or not dir then return end
          vim.fn.setreg("+", dir .. entry.name)
        end,
      },
    },
  },
}
