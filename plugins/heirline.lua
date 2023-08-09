return {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require("astronvim.utils.status")
      local harpoon_index = {
        provider = function()
          local Marked = require("harpoon.mark")
          local filename = vim.api.nvim_buf_get_name(0)
          local ok, index = pcall(Marked.get_index_of, filename)
          if ok and index and index > 0 then
            return "󱡀 " .. index .. " "
          else
            return
          end
        end,
      }

      opts.tabline = { -- bufferline
        { -- file tree padding
          condition = function(self)
            self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
            return status.condition.buffer_matches(
              { filetype = { "aerial", "dapui_.", "dap-repl", "neo%-tree", "NvimTree", "edgy" } },
              vim.api.nvim_win_get_buf(self.winid)
            )
          end,
          provider = function(self) return string.rep(" ", vim.api.nvim_win_get_width(self.winid) + 1) end,
          hl = { bg = "tabline_bg" },
        },
        status.component.fill { hl = { bg = "tabline_bg" } }, -- fill the rest of the tabline with background color
        { -- tab list
          condition = function() return #vim.api.nvim_list_tabpages() >= 2 end, -- only show tabs if there are more than one
          status.heirline.make_tablist { -- component for each tab
            provider = status.provider.tabnr(),
            hl = function(self) return status.hl.get_attributes(status.heirline.tab_type(self, "tab"), true) end,
          },
        },
      }

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
          update = "BufModifiedSet"
        },
        status.component.git_branch(),
        harpoon_index,
        status.component.git_diff(),
        status.component.diagnostics(),
        status.component.fill(),
        -- lsp causes issue on mac with tokyonight(https://discord.com/channels/939594913560031363/1100223017017163826)
        status.component.cmd_info(),
        status.component.fill(),
        status.component.lsp(),
        status.component.treesitter(),
        status.component.builder {
          {
            provider = function()
              local map = { ["unix"] = "LF", ["mac"] = "CR", ["dos"] = "CRLF" }
              return map[vim.bo.fileformat]
            end,
          },
          surround = {
            separator = "right",
          },
        },
        status.component.nav(),
      }
      return opts
    end,
  }
