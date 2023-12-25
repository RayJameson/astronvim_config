if true then return {} end
---Return `date` with Monday as first day of week
---@param date table
---@return osdate
local function monday_start(date)
  date.wday = date.wday == 1 and 7 or date.wday - 1
  return date
end

local get_week_nr = function()
  local date = os.date("*t")
  date.wday = date.wday == 1 and 7 or date.wday - 1
  local week_map = {}
  local current_week = 1
  for i = 1, date.day do
    local i_date = monday_start(os.date("*t", os.time { year = date.year, month = date.month, day = i }))
    week_map[i] = current_week
    if i_date.wday == 7 then current_week = current_week + 1 end
  end
  date.wnum = week_map[date.day]
  return tostring(date.wnum)
end

local date_with_current_week = function() return os.date("%Y/%m/") .. "W" .. get_week_nr() end
local utils = require("astronvim.utils")

return {
  {
    "nvim-orgmode/orgmode",
    cond = not vim.g.vscode,
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
        callback = function() vim.wo.foldlevel = package.loaded["ufo"] and 99 or vim.wo.foldlevel end,
      })
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "org", "orgagenda" },
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
      require("cmp").setup.filetype({ "org", "orgagenda" }, {
        sources = {
          name = "orgmode",
        },
      })
      return {
        org_agenda_files = org_path("**/*"),
        org_default_notes_file = org_path("refile.org"),
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
          r = {
            description = "Refile",
            template = "\n* TODO %?\n  DEADLINE: %T",
          },
          t = {
            description = "Todo (no category)",
            template = "\n* TODO %?\n  DEADLINE: %T",
            target = org_path("todos.org"),
          },
          w = {
            description = "Work week todo",
            template = "\n* TODO %?\n  DEADLINE: %T",
            target = org_path("work/" .. date_with_current_week() .. "/work.org"),
          },
          j = {
            description = "Journal",
            template = "\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?",
            target = org_path("journal.org"),
          },
          e = "Event",
          er = {
            description = "Recurring",
            template = "** %?\n %T",
            target = org_path("calendar.org"),
            headline = "Recurring",
          },
          eo = {
            description = "One time",
            template = "** %?\n %T",
            target = org_path("calendar.org"),
            headline = "One time",
          },
          eb = {
            description = "Birthdays",
            template = "** %?\n %T",
            target = org_path("calendar.org"),
            headline = "Birthdays",
          },
        },
        org_log_done = "note",
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      require("orgmode").setup_ts_grammar()
      opts.highlight.additional_vim_regex_highlighting = { "org" }
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "org" })
      end
    end,
  },
}
