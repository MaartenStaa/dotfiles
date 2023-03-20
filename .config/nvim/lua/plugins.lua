-- Automatically bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
  -- Let packer manage itself
  'wbthomason/packer.nvim',

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
  'editorconfig/editorconfig-vim',
  'fladson/vim-kitty',
  'sheerun/vim-polyglot',

  -- LSP & autocomplete
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'hrsh7th/nvim-cmp',
  'neovim/nvim-lspconfig',
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  'nvim-lua/lsp_extensions.nvim',
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  'nvim-treesitter/nvim-treesitter-textobjects',
  {
    'ray-x/lsp_signature.nvim',
    config = true
  },
  'sirver/ultisnips', -- CMP requires a snippet engine
  'williamboman/nvim-lsp-installer',

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
      vim.g.gitblame_ignored_filetypes = { 'terminal', '' }
    end
  },
  'junegunn/goyo.vim', -- Distraction free mode
  {
    'karb94/neoscroll.nvim',
    config = true
  },
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons'
    },
    tag = 'nightly', -- updated every week
    keys = {
      { '<Leader>b', '<cmd>NvimTreeFindFileToggle<CR>' }
    },
    config = function ()
      require('nvim-tree').setup({
        sync_root_with_cwd = true,
        renderer = {
          highlight_git = true
        },
        update_focused_file = {
          enable = true
        }
      })
    end
  },
  'kyazdani42/nvim-web-devicons',
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.opt.list = true
      vim.opt.listchars:append "lead:⋅"
      vim.opt.listchars:append "trail:⋅"
      vim.opt.listchars:append "eol:↴"
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
    dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = true
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
    dependencies = { 'kyazdani42/nvim-web-devicons' },
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
            ['ctrl-l']  = actions.file_sel_to_ll
          }
        }
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
  'theHamsta/nvim-dap-virtual-text',

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
    'rizzatti/dash.vim',
    keys = {
      { '<Leader>h', '<cmd><Plug>DashKeywords<CR>' }
    }
  },
  {
    -- Autoformatting
    'sbdchd/neoformat',
    config = function()
      -- Look for project Prettier install
      vim.g.neoformat_try_node_exe = 1
      vim.g.neoformat_only_msg_on_error = 1

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
  'tpope/vim-vinegar', -- Netrw enhancements
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
