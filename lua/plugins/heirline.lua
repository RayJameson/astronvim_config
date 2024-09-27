---@type LazySpec
return {
  "rebelot/heirline.nvim",
  cond = not vim.g.vscode,
  opts = function(_, opts)
    local status = require("astroui.status")
    -- custom heirline statusline component for grapple

    local function dap_ui_component()
      return {
        status.component.builder {
          condition = function() return require("dap").session() ~= nil end,
          static = {
            symbols = {
              RUNNING = "",
              STOPPED = "",
            },
            colors = {
              RUNNING = require("colors").green_1,
              STOPPED = require("colors").red_6,
            },
          },
          provider = function(self)
            local mapped_debugger_status = require("dap").session().stopped_thread_id == nil and "RUNNING" or "STOPPED"
            self.color = self.colors[mapped_debugger_status]
            return self.symbols[mapped_debugger_status]
          end,
          hl = function(self) return { fg = self.color } end,
        },
      }
    end

    local function grapple()
      return status.component.builder {
        provider = function() return "󰛢 " .. require("grapple").name_or_index() end,
        condition = function()
          if not require("astrocore").is_available("grapple.nvim") then return false end
          return require("grapple").exists()
        end,
      }
    end
    local Spacer = { provider = " " }
    local function pad(child)
      return {
        condition = child.condition,
        Spacer,
        child,
        Spacer,
      }
    end
    local function OverseerTasksForStatus(status)
      return {
        condition = function(self) return self.tasks[status] end,
        provider = function(self) return string.format("%s%d", self.symbols[status], #self.tasks[status]) end,
        hl = function(self)
          return {
            fg = require("heirline.utils").get_highlight(string.format("Overseer%s", status)).fg,
          }
        end,
      }
    end
    local overseer = function()
      return status.component.builder {
        condition = function() return package.loaded.overseer end,
        init = function(self)
          local tasks = require("overseer.task_list").list_tasks { unique = true }
          local tasks_by_status = require("overseer.util").tbl_group_by(tasks, "status")
          self.tasks = tasks_by_status
        end,
        static = {
          symbols = {
            ["CANCELED"] = "󰜺 ",
            ["FAILURE"] = " ",
            ["SUCCESS"] = "󰄳 ",
            ["RUNNING"] = "󰑮 ",
          },
        },

        pad(OverseerTasksForStatus("CANCELED")),
        pad(OverseerTasksForStatus("RUNNING")),
        pad(OverseerTasksForStatus("SUCCESS")),
        pad(OverseerTasksForStatus("FAILURE")),
      }
    end

    local line_end = function()
      return status.component.builder {
        {
          provider = function()
            local map = { ["unix"] = "LF", ["mac"] = "CR", ["dos"] = "CRLF" }
            return map[vim.bo.fileformat]
          end,
        },
        surround = {
          separator = "right",
        },
      }
    end
    local function bad_encoding()
      return status.component.builder {
        provider = function() return vim.bo.fenc end,
        surround = {
          separator = "left",
        },
        condition = function() return vim.bo.fenc ~= "utf-8" end,
        hl = { fg = "orange", bold = true },
        update = "BufModifiedSet",
      }
    end

    opts.tabline = nil
    opts.statusline = {
      -- statusline
      hl = { fg = "fg", bg = "bg" },
      status.component.mode {
        mode_text = { padding = { left = 1, right = 1 } },
      }, -- add the mode text
      status.component.file_info {
        filetype = {},
        filename = false,
      },
      bad_encoding(),
      status.component.git_branch(),
      grapple(),
      status.component.diagnostics(),
      overseer(),
      status.component.fill(),
      -- lsp causes issue on mac with tokyonight(https://discord.com/channels/939594913560031363/1100223017017163826)
      status.component.cmd_info(),
      status.component.fill(),
      dap_ui_component(),
      status.component.lsp(),
      status.component.treesitter(),
      line_end(),
      status.component.nav(),
    }
    opts.tabline = {}
    return opts
  end,
}
