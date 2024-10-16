-- Treesitter
require 'nvim-treesitter.configs'.setup({
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "wgsl", "wgsl_bevy", "norg" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {}, -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  autotag = {
    enable = true
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["as"] = "@statement.outer",
        ["ir"] = "@return.inner",
        ["ar"] = "@return.outer",
      },
    },

    swap = {
      enable = true,

      swap_next = {
        ["<leader>m"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>M"] = "@parameter.inner",
      }
    },

    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]o"] = "@class.outer",
        ["]s"] = { query = { "@statement.outer", "@return_statement" } },
        ["]a"] = "@parameter.inner",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[o"] = "@class.outer",
        ["[s"] = { query = { "@statement.outer", "@return_statement" } },
        ["[a"] = "@parameter.inner",
      },
    },
  },
})
