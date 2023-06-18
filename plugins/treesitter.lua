return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", "nvim-treesitter/playground" },
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed =
      require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        "lua",
        "luadoc",
        "python",
        "rust",
        "vim",
        "markdown",
        "make",
        "json",
        "json5",
        "yaml",
        "toml",
        "bash",
        "gitcommit",
        "gitattributes",
        "gitignore",
        "git_config",
        "git_rebase",
      })
    opts.auto_install = vim.fn.executable("tree-sitter") == 1
    opts.matchup = { enable = true }
    opts.rainbow = { enable = true }
    opts.textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          aA = "@attribute.outer",
          iA = "@attribute.inner",
          ad = "@conditional.outer",
          id = "@conditional.inner",
          af = "@function.outer",
          ["if"] = "@function.inner",
          al = "@loop.outer",
          il = "@loop.inner",
          aP = "@parameter.outer",
          iP = "@parameter.inner",
          ar = "@regex.outer",
          ir = "@regex.inner",
          ac = "@class.outer",
          ic = "@class.inner",

          aS = "@statement.outer",
          iS = "@statement.outer",
          an = "@number.inner",
          ["in"] = "@number.inner",
          aC = "@comment.outer",
          iC = "@comment.outer",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]b"] = { query = "@block.outer", desc = "Next block start" },
          ["]f"] = { query = "@function.outer", desc = "Next function start" },
          ["]p"] = {
            query = "@parameter.outer",
            desc = "Next parameter start",
          },
          ["]x"] = { query = "@class.outer", desc = "Next class start" },
          ["]c"] = { query = "@comment.outer", desc = "Next comment start" },
        },
        goto_next_end = {
          ["]B"] = { query = "@block.outer", desc = "Next block end" },
          ["]F"] = { query = "@function.outer", desc = "Next function end" },
          ["]P"] = { query = "@parameter.outer", desc = "Next parameter end" },
          ["]X"] = { query = "@class.outer", desc = "Next class end" },
          ["]C"] = { query = "@comment.outer", desc = "Next comment end" },
        },
        goto_previous_start = {
          ["[b"] = { query = "@block.outer", desc = "Previous block start" },
          ["[f"] = {
            query = "@function.outer",
            desc = "Previous function start",
          },
          ["[p"] = {
            query = "@parameter.outer",
            desc = "Previous parameter start",
          },
          ["[x"] = { query = "@class.outer", desc = "Previous class start" },
          ["[c"] = {
            query = "@comment.outer",
            desc = "Previous comment start",
          },
        },
        goto_previous_end = {
          ["[B"] = { query = "@block.outer", desc = "Previous block end" },
          ["[F"] = {
            query = "@function.outer",
            desc = "Previous function end",
          },
          ["[P"] = {
            query = "@parameter.outer",
            desc = "Previous parameter end",
          },
          ["[X"] = { query = "@class.outer", desc = "Previous class end" },
          ["[C"] = { query = "@comment.outer", desc = "Previous comment end" },
        },
      },
      swap = {
        enable = true,
        swap_next = {
          [">B"] = { query = "@block.outer", desc = "Swap next block" },
          [">F"] = { query = "@function.outer", desc = "Swap next function" },
          [">P"] = { query = "@parameter.inner", desc = "Swap next parameter" },
        },
        swap_previous = {
          ["<B"] = { query = "@block.outer", desc = "Swap previous block" },
          ["<F"] = {
            query = "@function.outer",
            desc = "Swap previous function",
          },
          ["<P"] = {
            query = "@parameter.inner",
            desc = "Swap previous parameter",
          },
        },
      },
      lsp_interop = {
        enable = true,
        border = "single",
        peek_definition_code = {
          ["<leader>lp"] = {
            query = "@function.outer",
            desc = "Peek function definition",
          },
          ["<leader>lP"] = {
            query = "@class.outer",
            desc = "Peek class definition",
          },
        },
      },
    }
  end,
}
