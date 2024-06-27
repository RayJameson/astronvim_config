---@type LazySpec
return {
    "lewis6991/gitsigns.nvim",
    optional = true,
    keys = {
        { "<Leader>gP", function() require("gitsigns").preview_hunk() end, desc = "Preview Git hunk in pop up" },
    }
}
