return function()
    require("mind").setup {
        ui = {
            width = 50,
        },
        -- tree options
        tree = {
            -- automatically create data file when trying to open one that doesn’t
            -- have any data yet
            automatic_data_creation = false,
        },
    }
end
