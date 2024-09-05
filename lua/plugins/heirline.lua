---@type LazySpec
return {
  "rebelot/heirline.nvim",
  cond = not vim.g.vscode,
  opts = function(_, opts)
    local status = require("astroui.status")
    -- custom heirline statusline component for grapple
    local function grapple_component()
      return status.component.builder {
        provider = function() return "󰛢 " .. require("grapple").name_or_index() end,
        condition = function()
          if not require("astrocore").is_available("grapple.nvim") then return false end
          return require("grapple").exists()
        end,
      }
    end
    local Spacer = { provider = " " }
    local function rpad(child)
      return {
        condition = child.condition,
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
    local overseer_component = {
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

      rpad(OverseerTasksForStatus("CANCELED")),
      rpad(OverseerTasksForStatus("RUNNING")),
      rpad(OverseerTasksForStatus("SUCCESS")),
      rpad(OverseerTasksForStatus("FAILURE")),
    }

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
      status.component.builder {
        { provider = function() return vim.bo.fenc end },
        surround = {
          separator = "left",
          condition = function() return vim.bo.fenc ~= "utf-8" end,
        },
        hl = { fg = "orange" },
        update = "BufModifiedSet",
      },
      status.component.git_branch(),
      grapple_component(),
      status.component.git_diff(),
      status.component.diagnostics(),
      overseer_component,
      status.component.fill(),
      -- lsp causes issue on mac with tokyonight(https://discord.com/channels/939594913560031363/1100223017017163826)
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp(),
      status.component.treesitter(),
      line_end(),
      status.component.nav(),
    }
    opts.tabline = {}
    return opts
  end,
}
