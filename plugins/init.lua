--[[   Packer optional commands for plugins
  {"myusername/example",
  or
  ["myusername/example"] = {        -- The plugin location string

  The following keys are all optional
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
}
--]]

local function add_to_lazy_file_plugins(plugin) table.insert(astronvim.file_plugins, plugin) end

local function add_to_lazy_git_plugins(plugin) table.insert(astronvim.git_plugins, plugin) end

return {
    -- You can disable default plugins as follows:
    -- [] = { disable = true },
    ["Darazaki/indent-o-matic"] = { disable = true },
    -- modify existing cmp sources
    ["hrsh7th/nvim-cmp"] = { keys = { ":", "/", "?" } },

    -- You can also add new plugins here as well:
    -- Add plugins, the packer syntax without the "use"
    -- { "andweeb/presence.nvim" },
    -- ["andweeb/presence.nvim"] = {},
    ------------------------------------------------------
    -- User plugins without config files in user_plugins folder:
    ------------------------------------------------------
    ["sitiom/nvim-numbertoggle"] = {
        opt = true,
        setup = "nvim-numbertoggle",
        config = function() require("numbertoggle").setup() end,
    },
    ["yioneko/nvim-yati"] = {
        tag = "*",
        after = "nvim-treesitter",
    },
    ["xiyaowong/virtcolumn.nvim"] = {
        opt = true,
        setup = add_to_lazy_file_plugins("virtcolumn.nvim"),
    },
    ["ahmedkhalf/project.nvim"] = {
        opt = true,
        after = "telescope.nvim",
        config = require("user.user_plugins.project"),
    },
    ["kevinhwang91/rnvimr"] = {
        opt = true,
        cmd = { "RnvimrToggle", "RnvimrResize" },
    },
    ["ThePrimeagen/vim-be-good"] = {
        opt = true,
        cmd = "VimBeGood",
    },
    ["mbbill/undotree"] = {
        opt = true,
        setup = add_to_lazy_file_plugins("undotree"),
    },
    ["fedepujol/move.nvim"] = {
        opt = true,
        setup = add_to_lazy_file_plugins("move.nvim"),
    },
    ["mfussenegger/nvim-dap"] = {
        opt = true,
        setup = add_to_lazy_file_plugins("nvim-dap"),
    },
    ["mfussenegger/nvim-dap-python"] = {
        opt = true,
        after = { "mason-nvim-dap.nvim", "nvim-dap" },
        ft = "python",
        config = function() require("dap-python").setup("~/.virtualenvs/debugpy/bin/python") end,
    },
    ["folke/trouble.nvim"] = {
        opt = true,
        setup = add_to_lazy_file_plugins("trouble.nvim"),
        config = function() require("trouble").setup() end,
    },
    ["ray-x/lsp_signature.nvim"] = {
        opt = true,
        setup = add_to_lazy_file_plugins("lsp_signature.nvim"),
        config = function() require("lsp_signature").setup() end,
    },
    ["andymass/vim-matchup"] = {
        opt = true,
        setup = add_to_lazy_file_plugins("vim-matchup"),
        config = function() vim.g.matchup_matchparen_offscreen = { method = "popup" } end,
    },
    ["nvim-treesitter/nvim-treesitter-context"] = {
        after = "nvim-treesitter",
        config = function() require("treesitter-context").setup() end,
    },
    ["nvim-treesitter/nvim-treesitter-textobjects"] = {
        after = "nvim-treesitter",
    },
    ["iamcco/markdown-preview.nvim"] = {
        run = function() vim.fn["mkdp#util#install"]() end,
        ft = "markdown",
    },
    ["ThePrimeagen/refactoring.nvim"] = {
        opt = true,
        config = function() require("telescope").load_extension("refactoring") end,
        cmd = "Refactoring",
    },
    ["joechrisellis/lsp-format-modifications.nvim"] = {
        module = "lsp-format-modifications",
    },
    ["sindrets/diffview.nvim"] = {
        opt = true,
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        config = function() require("diffview").setup() end,
    },
    ["aserowy/tmux.nvim"] = {
        opt = true,
        cond = function() return vim.fn.exists("$TMUX") == 1 end,
        config = require("user.user_plugins.tmux"),
    },
    ["folke/todo-comments.nvim"] = {
        opt = true,
        setup = add_to_lazy_file_plugins("todo-comments.nvim"),
        config = function() require("todo-comments").setup() end,
    },
    ["kylechui/nvim-surround"] = {
        opt = true,
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function() require("nvim-surround").setup() end,
        setup = add_to_lazy_file_plugins("nvim-surround"),
    },
    ---------------------------------------------------
    --  Plugins with config set in user_plugins files:
    ---------------------------------------------------
    ["f-person/git-blame.nvim"] = {
        opt = true,
        setup = add_to_lazy_git_plugins("git-blame.nvim"),
        config = require("user.user_plugins.git-blame"),
    },
    ["ellisonleao/glow.nvim"] = {
        opt = true,
        ft = "markdown",
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
    ["jayp0521/mason-nvim-dap.nvim"] = {
        opt = true,
        after = { "mason.nvim", "nvim-dap" },
        config = require("user.user_plugins.mason-nvim-dap"),
    },
    ["rcarriga/nvim-dap-ui"] = {
        opt = true,
        after = "nvim-dap",
        config = require("user.user_plugins.nvim-dap-ui"),
    },
    ["m-demare/hlargs.nvim"] = {
        opt = true,
        setup = add_to_lazy_file_plugins("hlargs.nvim"),
        config = require("user.user_plugins.hlargs"),
    },
    ["andweeb/presence.nvim"] = {
        config = require("user.user_plugins.presence"),
    },
}
