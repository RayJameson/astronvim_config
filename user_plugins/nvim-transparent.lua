return function()
    require("transparent").setup {
        extra_groups = { -- table/string: additional groups that should be cleared
            -- In particular, when you set it to 'all', that means all available groups
            "NeoTreeNormal",
            "NeoTreeNormalNC",
            "NeoTreePreview",
            "NeoTreeTabInactive",
            "NeoTreeTabSeparatorInactive",
            "CursorLine",
            "FloatBorder",
            "WinBar",
            "WinBarNC",
            "TreesitterContext",
            "Pmenu",
            "DapUIPlayPause",
            "DapUIRestart",
            "DapUIStop",
            "DapUIStepOut",
            "DapUIStepBack",
            "DapUIStepInto",
            "DapUIStepOver",
            "DapUIPlayPauseNC",
            "DapUIRestartNC",
            "DapUIStopNC",
            "DapUIStepOutNC",
            "DapUIStepBackNC",
            "DapUIStepIntoNC",
            "DapUIStepOverNC",
        },
        exclude_groups = {}, -- table: groups you don't want to clear
    }
end
