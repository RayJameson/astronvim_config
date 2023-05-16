local M = {}
---Run Lua code like `luafile %` but in new window instead of default output
---@param fargs table Getting this argument from command call like `BetterLuaFile` /path/to/file default: %
---@param orientation "horizontal"|"vertical" Orientation of created window
---@param size integer Size of created window
---@param focus boolean Focus created window
function M.call(fargs, orientation, size, focus)
    local file = fargs[1] or "%"
    orientation = orientation or "horizontal"
    size = size or 15
    focus = focus or true
    local error = vim.log.levels.ERROR
    -- Get code run output
    local original_window_number = vim.api.nvim_get_current_win()
    local code_run_output = vim.fn.execute(("luafile %s"):format(file))
    local code_output_table = vim.split(code_run_output, "\n", {})
    -- Make new window
    if orientation == "horizontal" then
        vim.cmd(("%i split"):format(size))
    elseif orientation == "vertical" then
        vim.cmd(("%i vsplit"):format(size))
    else
        local error_msg = ("Wrong orientation settings: '%s'\nShould be 'vertical' or 'horizontal'"):format(orientation)
        vim.schedule(function()
            vim.notify(error_msg, error, { title = "BetterLuafile" })
        end)
        return
    end
    local new_window_number = vim.api.nvim_get_current_win()
    -- Create new and set buffer in just created window
    local new_buffer_number = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(new_window_number, new_buffer_number)
    -- Write code_output_table to new buffer
    vim.api.nvim_buf_set_lines(new_buffer_number, 0, -1, false, code_output_table)
    -- Disable number and relativenumber for better look
    vim.api.nvim_win_set_option(new_window_number, "number", false)
    vim.api.nvim_win_set_option(new_window_number, "relativenumber", false)
    -- Prevent edit as we only outputting information
    vim.api.nvim_buf_set_option(new_buffer_number, "modifiable", false)
    -- Focus on original window if needed
    if not focus then
        vim.api.nvim_set_current_win(original_window_number)
    end
end

return M
