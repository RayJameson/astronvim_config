return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  dependencies = {
    "akinsho/org-bullets.nvim",
    opts = {
      concealcursor = true,
      symbols = {
        checkboxes = {
          half = {
            vim.g.icons_enabled and "󰥔" or "-",
            "OrgTSCheckboxHalfChecked",
          },
          done = { vim.g.icons_enabled and "󰄬" or "X", "OrgDone" },
          todo = { " ", "OrgTODO" },
        },
      },
    },
  },
  init = function()
    vim.api.nvim_create_augroup("OrgSetup", { clear = true })
    vim.api.nvim_create_autocmd({ "FileType" }, {
      pattern = "org",
      group = "OrgSetup",
      callback = function()
        vim.wo.foldlevel = package.loaded["ufo"] and 99 or vim.wo.foldlevel
      end,
    })
    vim.api.nvim_create_autocmd({ "FileType" }, {
      pattern = "org",
      group = "OrgSetup",
      callback = function()
        vim.wo.conceallevel = 2
        vim.wo.concealcursor = "ncv"
      end,
    })
  end,
  opts = function()
    local org_path = function(path)
      local org_directory = vim.env.HOME .. "/org"
      return ("%s/%s"):format(org_directory, path)
    end
    return {
      org_agenda_files = org_path("**/*"),
      org_default_notes_file = org_path("refile.org"),
      org_agenda_start_on_weekday = false,
      org_todo_keywords = {
        "TODO(t)",
        "PROGRESS(p)",
        "|",
        "DONE(d)",
        "CANCELLED(c)",
      },
      mappings = {
        org = {
          org_toggle_checkbox = "<M-Space>",
        },
      },
      org_capture_templates = {
        t = {
          description = "Refile",
          template = "* TODO %?\n  DEADLINE: %T",
        },
        T = {
          description = "Todo (no category)",
          template = "* TODO %?\n  DEADLINE: %T",
          target = org_path("todos.org"),
        },
        w = {
          description = "Work todo",
          template = "* TODO %?\n  DEADLINE: %T",
          target = org_path("work.org"),
        },
      },
    }
  end,
}
