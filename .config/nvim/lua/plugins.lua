-- Automatically bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- vim.cmd([[
--   augroup lazy_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | Lazy sync
--   augroup end
-- ]])

return require('lazy').setup({
  -- Theming
  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme onedark]])
    end
  },
  -- 'doums/darcula',
  -- 'mofiqul/dracula.nvim',
  -- 'rktjmp/lush.nvim',
  -- 'skielbasa/vim-material-monokai',

  -- Language support
  '2072/php-indenting-for-vim',
  'b0o/schemastore.nvim',
  'editorconfig/editorconfig-vim',
  'fladson/vim-kitty',
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  'qnighy/lalrpop.vim',
  'sheerun/vim-polyglot',

  -- LSP & autocomplete
  {
    'github/copilot.vim',
    enabled = false,
  },
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'sirver/ultisnips' }
  },
  'neovim/nvim-lspconfig',
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  'nvim-lua/lsp_extensions.nvim',
  'nvim-treesitter/nvim-treesitter-textobjects',
  {
    'ray-x/lsp_signature.nvim',
    config = true,
    enabled = false,
  },
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  -- 'williamboman/nvim-lsp-installer',

  -- UI enhancements
  -- Highlight other uses of item under cursor
  {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure({
        providers = {
          'lsp',
          'treesitter'
        },
        delay = 10,
        under_cursor = true
      })
    end
  },
  'airblade/vim-gitgutter',
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    keys = '<A-t>',
    opts = {
      size = function()
        return vim.opt.columns:get() / 3 * 2
      end,
      open_mapping = '<A-t>',
      direction = 'vertical'
    }
  },
  {
    'f-person/git-blame.nvim',
    config = function()
      vim.g.gitblame_set_extmark_options = {
        hl_mode = "combine",
      }
      vim.g.gitblame_ignored_filetypes = { 'terminal', '', 'toggleterm' }
    end
  },
  {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      cmdline = {
        -- view = 'cmdline',
      },
      messages = {
        view_search = false,
      },
    },
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      height = 20,
      use_diagnostic_signs = true,
    },
  },
  {
    'folke/which-key.nvim',
     event = "VeryLazy",
     init = function()
       vim.o.timeout = true
       vim.o.timeoutlen = 500
     end,
     opts = {},
  },
  'junegunn/goyo.vim', -- Distraction free mode
  {
    'karb94/neoscroll.nvim',
    config = true
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    tag = 'nightly', -- updated every week
    keys = {
      { '<Leader>b', '<cmd>NvimTreeFindFileToggle<CR>' }
    },
    config = function ()
      require('nvim-tree').setup({
        sync_root_with_cwd = true,
        renderer = {
          highlight_git = true,
        },
        update_focused_file = {
          enable = true,
        },
        filesystem_watchers = {
          ignore_dirs = {
            ".*/node_modules/.*",
          },
        },
      })
    end
  },
  'nvim-tree/nvim-web-devicons',
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.opt.list = true
      vim.opt.listchars:append "lead:⋅"
      vim.opt.listchars:append "trail:⋅"
      -- vim.opt.listchars:append "eol:↴"
      require('indent_blankline').setup({
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true
      })
    end
  },
  'machakann/vim-highlightedyank',
  'markonm/traces.vim', -- Preview for substitutions
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup({
        enable = true,
        max_lines = 0
      })
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    opts = {
      options = {
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
      },
      sections = {
        lualine_c = { { 'filename', path = 1 } }
      }
    }
  },
  {
    'petertriho/nvim-scrollbar',
    config = true
  },
  'romgrk/barbar.nvim',
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- Refactoring
  -- {
  --   'ThePrimeagen/refactoring.nvim',
  --   dependencies = {
  --     { 'nvim-lua/plenary.nvim' },
  --     { 'nvim-treesitter/nvim-treesitter' }
  --   },
  --   config = true
  -- }

  -- Integration with GitHub/GHE
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- 'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      default_remote = { 'upstream', 'maartens', 'origin' },
      picker = 'fzf-lua',
    },
  },

  -- For easy navigation
  {
    'ggandor/leap.nvim',
    keys = { 's', 'S', 'gs', 'X' },
    config = function ()
      require('leap').add_default_mappings()
    end
  },
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
      local fzf = require('fzf-lua')
      local actions = require 'fzf-lua.actions'

      fzf.register_ui_select()
      fzf.setup({
        actions = {
          files = {
            ['default'] = actions.file_edit_or_qf,
            ['ctrl-s']  = actions.file_split,
            ['ctrl-v']  = actions.file_vsplit,
            ['ctrl-t']  = actions.file_tabedit,
            ['ctrl-q']  = actions.file_sel_to_qf,
            ['ctrl-l']  = actions.file_sel_to_ll,
          }
        },
        commands = { sort_lastused = true },
        git = {
          files = {
            cmd = 'git ls-files --cached --others --exclude-standard',
          },
        },
      })
    end
  },

  -- Debugging
  'mfussenegger/nvim-dap',
  { 'mxsdev/nvim-dap-vscode-js', dependencies = { 'mfussenegger/nvim-dap' } },
  {
    'microsoft/vscode-js-debug',
    lazy = true,
    build = 'npm install --legacy-peer-deps && npm run compile && git checkout package-lock.json'
  }, -- For nvim-dap-vscode-js
  'rcarriga/nvim-dap-ui',
  {
    'theHamsta/nvim-dap-virtual-text',
    branch = 'inline-text',
    config = true,
  },

  -- Misc
  {
    -- Automatically track sessions per directory
    'Shatur/neovim-session-manager',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('session_manager').setup({
        autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir,
        autosave_only_in_session = false
      })
    end
  },
  {
    -- Integration with Dash (search docs)
    'okuramasafumi/dash.nvim',
    branch = 'fix-crash-with-fzf-lua',
    build = 'make install',
    keys = {
      { '<Leader>h', '<cmd>Dash<CR>' }
    },
    opts = {
      search_engine = 'startpage',
      file_type_keywords = {
        javascript = { 'javascript', 'nodejs' },
        typescript = { 'typescript', 'javascript', 'nodejs' },
        typescriptreact = { 'typescript', 'javascript', 'react' },
        javascriptreact = { 'javascript', 'react' },
      },
    },
  },
  {
    -- Autoformatting
    'sbdchd/neoformat',
    config = function()
      -- Look for project Prettier install
      vim.g.neoformat_try_node_exe = 1
      vim.g.neoformat_only_msg_on_error = 1

      -- Tweak autopep8 configuration
      vim.g.neoformat_python_autopep8 = {
        exe = 'autopep8',
        args = { '-', '--max-line-length', '100' },
        stdin = 1,
      }
      vim.g.neoformat_enabled_python = { 'autopep8' }

      local augroup = vim.api.nvim_create_augroup('fmt', { clear = true })
      vim.api.nvim_create_autocmd('BufWritePre', {
        command = 'try | undojoin | Neoformat | catch /E790/ | Neoformat | endtry',
        group = augroup
      })
    end
  },
  'schickling/vim-bufonly', -- Add :BufOnly command
  'tpope/vim-commentary', -- Toggle comments
  'tpope/vim-repeat', -- Handles repeating plugin commands as a whole
  'tpope/vim-sensible', -- Set some sensible defaults
  'tpope/vim-surround', -- Add/change/remove surrounding brackets
  -- 'tpope/vim-vinegar', -- Netrw enhancements
  {
    -- Automatically insert matching brackets, and jump over them when typing them
    'windwp/nvim-autopairs',
    config = function()
      local autopairs = require('nvim-autopairs')
      autopairs.setup({
        check_ts = true
      })

      local Rule = require('nvim-autopairs.rule')
      autopairs.add_rule(
        Rule("%<%>$", "</>", { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' })
        :use_regex(true)
      )
    end
  },
  'windwp/nvim-ts-autotag', -- And kind of the same for tags (HTML, JSX)
}, {
  install = {
    colorscheme = { 'onedark' }
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'netrwPlugin'
      }
    }
  },
  profile = {
    enable = true
  }
})
