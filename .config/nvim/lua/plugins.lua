-- Automatically bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup({ function(use)
  -- Let packer manage itself
  use 'wbthomason/packer.nvim'

  -- Theming
  use 'navarasu/onedark.nvim'
  -- use 'doums/darcula'
  -- use 'mofiqul/dracula.nvim'
  -- use 'rktjmp/lush.nvim'
  -- use 'skielbasa/vim-material-monokai'

  -- Language support
  use '2072/php-indenting-for-vim'
  use 'editorconfig/editorconfig-vim'
  use 'fladson/vim-kitty'
  use 'sheerun/vim-polyglot'

  -- LSP & autocomplete
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp_extensions.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use {
    'ray-x/lsp_signature.nvim',
    config = function ()
      require 'lsp_signature'.setup({})
    end
  }
  use 'sirver/ultisnips' -- CMP requires a snippet engine
  use 'williamboman/nvim-lsp-installer'

  -- UI enhancements
  use { 'RRethy/vim-illuminate', config = function()
    require('illuminate').configure({
      providers = {
        'lsp',
        'treesitter'
      },
      delay = 10,
      under_cursor = true
    })
  end } -- Highlight other uses of item under cursor
  use 'airblade/vim-gitgutter'
  use 'itchyny/lightline.vim'
  use 'josa42/nvim-lightline-lsp'
  use 'junegunn/goyo.vim' -- Distraction free mode
  use {
    'karb94/neoscroll.nvim',
    config = function ()
      require('neoscroll').setup()
    end
  }
  use 'kyazdani42/nvim-web-devicons'
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.opt.list = true
      vim.opt.listchars:append "lead:⋅"
      vim.opt.listchars:append "trail:⋅"
      vim.opt.listchars:append "eol:↴"
      require('indent_blankline').setup({
        space_char_blankline = "",
        show_current_context = true,
        show_current_context_start = true
      })
    end
  }
  use 'machakann/vim-highlightedyank'
  use 'markonm/traces.vim' -- Preview for substitutions
  use {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup({
        enable = true,
        max_lines = 0
      })
    end
  }
  use {
    'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup()
    end
  }
  use 'romgrk/barbar.nvim'
  use 'scrooloose/nerdtree'

  -- Refactoring
  use {
    'ThePrimeagen/refactoring.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' }
    },
    config = function()
      require('refactoring').setup({})
    end
  }

  -- For easy navigation
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  use 'nvim-telescope/telescope-ui-select.nvim' -- Style ui-select (like code actions) with telescope

  -- Debugging
  use 'mfussenegger/nvim-dap'
  use { 'mxsdev/nvim-dap-vscode-js', requires = { 'mfussenegger/nvim-dap' } }
  use { 'microsoft/vscode-js-debug', opt = true, run = 'npm install --legacy-peer-deps && npm run compile' } -- For nvim-dap-vscode-js
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'

  -- Misc
  -- use 'junegunn/fzf' -- Fuzzy file finder
  use {
    -- Automatically track sessions per directory
    'Shatur/neovim-session-manager',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function ()
      require('session_manager').setup({
        autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir,
        autosave_only_in_session = false
      })
    end
  }
  use 'itchyny/vim-gitbranch' -- Provides gitbranch#name for lightline
  use 'justinmk/vim-sneak' -- f and t across lines
  use 'rizzatti/dash.vim' -- Integration with Dash (search docs)
  use 'sbdchd/neoformat' -- Autoformatting
  use 'schickling/vim-bufonly' -- Add :BufOnly command
  use 'tpope/vim-commentary' -- Toggle comments
  use 'tpope/vim-repeat' -- Handles repeating plugin commands as a whole
  use 'tpope/vim-sensible' -- Set some sensible defaults
  use 'tpope/vim-surround' -- Add/change/remove surrounding brackets
  use 'tpope/vim-vinegar' -- Netrw enhancements
  use {
    -- Automatically insert matching brackets, and jump over them when typing them
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
        check_ts = true
      })
    end
  }
  use 'windwp/nvim-ts-autotag' -- And kind of the same for tags (HTML, JSX)

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    },
    profile = {
      enable = true
    }
  }
})
