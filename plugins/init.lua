--[[
    {{{
    vim: set foldmethod=marker :
    vim: set foldlevel=0 :
    Add plugins, the packer syntax without the "use":
      { "andweeb/presence.nvim" },
      ["andweeb/presence.nvim"] = {},

    Packer optional commands for plugins:
    disable = boolean,                -- Mark a plugin as inactive
    as = string,                      -- Specifies an alias under which to install the plugin
    installer = function,             -- Specifies custom installer. See "custom installers" below.
    updater = function,               -- Specifies custom updater. See "custom installers" below.
    after = string or list,           -- Specifies plugins to load before this plugin. See "sequencing" below
    rtp = string,                     -- Specifies a subdirectory of the plugin to add to runtimepath.
    opt = boolean,                    -- Manually marks a plugin as optional.
    bufread = boolean,                -- Manually specifying if a plugin needs BufRead after being loaded
    branch = string,                  -- Specifies a git branch to use
    tag = string,                     -- Specifies a git tag to use. Supports '*' for "latest tag"
    commit = string,                  -- Specifies a git commit to use
    lock = boolean,                   -- Skip updating this plugin in updates/syncs. Still cleans.
    run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
    requires = string or list,        -- Specifies plugin dependencies. See "dependencies".
    rocks = string or list,           -- Specifies Luarocks dependencies for the plugin
    config = string or function,      -- Specifies code to run after this plugin is loaded.

    The setup key implies opt = true
    setup = string or function,       -- Specifies code to run before this plugin is loaded. The code is ran even if

    The following keys all imply lazy-loading and imply opt = true
    cmd = string or list,             -- Specifies commands which load this plugin. Can be an autocmd pattern.
    ft = string or list,              -- Specifies filetypes which load this plugin.
    keys = string or list,            -- Specifies maps which load this plugin. See "Keybindings".
    event = string or list,           -- Specifies autocommand events which load this plugin.
    fn = string or list               -- Specifies functions which load this plugin.
    cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
    module = string or list           -- Specifies Lua module names for require. When requiring a string which starts
                                      -- with one of these module names, the plugin will be loaded.
    module_pattern = string/list      -- Specifies Lua pattern of Lua module names for require. When
                                      -- requiring a string which matches one of these patterns, the plugin will be loaded.
    }}}
--]]

local function add_to_lazy_file_plugins(plugin)
    table.insert(astronvim.file_plugins, plugin)
end
local function add_to_lazy_git_plugins(plugin)
    table.insert(astronvim.git_plugins, plugin)
end

return {
    ------------------------------------------------------------
    --           Core plugins modifying configuration:
    ------------------------------------------------------------
    -- {{{
    -- You can disable default plugins as follows:
    -- [] = { disable = true },

    -- I don't like this plugin
    -- ["Darazaki/indent-o-matic"] = { disable = true },
    ["hrsh7th/nvim-cmp"] = { keys = { ":", "/", "?" } },
    -- add more custom sources
    ["hrsh7th/cmp-cmdline"] = { after = "nvim-cmp" },
    -- }}}
    ------------------------------------------------------------
    -- User plugins without config files in user_plugins folder:
    ------------------------------------------------------------
    -- {{{
    {
        -- setting up this plugin in lsp/server-settings/sumneko_lua
        "folke/neodev.nvim",
    },
    ["nvim-neotest/neotest"] = require("user.user_plugins.neotest"),
    ["saecki/crates.nvim"] = require("user.user_plugins.crates"),
    ["kevinhwang91/nvim-ufo"] = require("user.user_plugins.nvim-ufo"),
    ["theHamsta/nvim-dap-virtual-text"] = require("user.user_plugins.nvim-dap-virtual-text"),
    ["yioneko/nvim-yati"] = require("user.user_plugins.nvim-yati"),
    ["xiyaowong/virtcolumn.nvim"] = require("user.user_plugins.virtcolumn"),
    ["ThePrimeagen/vim-be-good"] = require("user.user_plugins.vim-be-good"),
    ["mbbill/undotree"] = require("user.user_plugins.undotree"),
    ["fedepujol/move.nvim"] = require("user.user_plugins.move"),
    ["folke/trouble.nvim"] = require("user.user_plugins.trouble"),
    ["ray-x/lsp_signature.nvim"] = require("user.user_plugins.lsp_signature"),
    ["andymass/vim-matchup"] = require("user.user_plugins.vim-mathup"),
    ["nvim-treesitter/nvim-treesitter-context"] = require("user.user_plugins.nvim-treesitter-context"),
    ["nvim-treesitter/nvim-treesitter-textobjects"] = require("user.user_plugins.nvim-treesitter-textobjects"),
    ["iamcco/markdown-preview.nvim"] = require("user.user_plugins.markdown-preview"),
    ["joechrisellis/lsp-format-modifications.nvim"] = require("user.user_plugins.lsp-format-modifications"),
    ["folke/todo-comments.nvim"] = require("user.user_plugins.todo-comments"),
    ["kylechui/nvim-surround"] = require("user.user_plugins.nvim-surround"),

    -- }}}
    ------------------------------------------------------------
    --     Plugins with config set in "user_plugins" folder:
    ------------------------------------------------------------
    -- {{{
    ["sindrets/diffview.nvim"] = {
        disable = vim.fn.executable("git") <= 0,
        opt = true,
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        config = require("user.user_plugins.diffview"),
    },
    ["ThePrimeagen/refactoring.nvim"] = {
        opt = true,
        config = require("user.user_plugins.refactoring"),
        cmd = "Refactoring",
    },
    ["ahmedkhalf/project.nvim"] = {
        opt = true,
        after = "telescope.nvim",
        config = require("user.user_plugins.project"),
    },
    ["lvimuser/lsp-inlayhints.nvim"] = {
        module = "lsp-inlayhints",
        config = require("user.user_plugins.lsp-inlayhints"),
    },
    ["simrat39/rust-tools.nvim"] = {
        ft = "rust",
        after = "mason-lspconfig.nvim",
        config = require("user.user_plugins.rust_tools"),
    },
    ["xiyaowong/nvim-transparent"] = {
        config = require("user.user_plugins.nvim-transparent"),
    },
    ["amrbashir/nvim-docs-view"] = {
        opt = true,
        cmd = { "DocsViewToggle" },
        config = require("user.user_plugins.docs-view"),
    },
    ["phaazon/mind.nvim"] = {
        opt = true,
        cmd = { "MindOpenMain", "MindOpenProject", "MindOpenSmartProject" },
        requires = { "nvim-lua/plenary.nvim" },
        config = require("user.user_plugins.mind"),
    },
    ["scalameta/nvim-metals"] = {
        disable = vim.fn.executable("coursier") <= 0,
        opt = true,
        config = require("user.user_plugins.nvim-metals"),
        -- Without sequencing Mason UI doens't work
        after = { "mason.nvim", "mason-lspconfig.nvim", "mason-null-ls.nvim" },
    },
    ["f-person/git-blame.nvim"] = {
        disable = vim.fn.executable("git") <= 0,
        opt = true,
        setup = add_to_lazy_git_plugins("git-blame.nvim"),
        config = require("user.user_plugins.git-blame"),
    },
    ["ellisonleao/glow.nvim"] = {
        opt = true,
        cmd = "Glow",
        config = require("user.user_plugins.glow"),
    },
    ["CRAG666/code_runner.nvim"] = {
        opt = true,
        cmd = { "RunCode", "RunFile" },
        config = require("user.user_plugins.code_runner"),
    },
    ["kevinhwang91/nvim-bqf"] = {
        opt = true,
        setup = add_to_lazy_file_plugins("nvim-bqf"),
        config = require("user.user_plugins.nvim-bqf"),
    },
    ["m-demare/hlargs.nvim"] = {
        requires = { "nvim-treesitter/nvim-treesitter" },
        opt = true,
        after = "nvim-treesitter",
        setup = add_to_lazy_file_plugins("hlargs.nvim"),
        config = require("user.user_plugins.hlargs"),
    },
    ["andweeb/presence.nvim"] = {
        config = require("user.user_plugins.presence"),
    },
    -- }}}
}
