call plug#begin('~/.config/nvim/plugged')

"Theming
Plug 'doums/darcula'
Plug 'mofiqul/dracula.nvim'
Plug 'navarasu/onedark.nvim'
Plug 'rktjmp/lush.nvim'
Plug 'skielbasa/vim-material-monokai'

"Language support
Plug '2072/php-indenting-for-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'fladson/vim-kitty'
Plug 'sheerun/vim-polyglot'

"LSP & autocomplete
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'ray-x/lsp_signature.nvim'
Plug 'sirver/ultisnips' "CMP requires a snippet engine
Plug 'williamboman/nvim-lsp-installer'

"UI enhancements
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'josa42/nvim-lightline-lsp'
Plug 'junegunn/goyo.vim' "Distraction free mode
Plug 'karb94/neoscroll.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'machakann/vim-highlightedyank'
Plug 'markonm/traces.vim' "Preview for substitutions
Plug 'nathanaelkane/vim-indent-guides'
Plug 'romgrk/barbar.nvim'
Plug 'scrooloose/nerdtree'

"For easy navigation
Plug 'nvim-lua/plenary.nvim' "Dependency of telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-telescope/telescope-ui-select.nvim' "Style ui-select (like code actions) with telescope

"Misc
Plug 'itchyny/vim-gitbranch' "Provides gitbranch#name for lightline
Plug 'junegunn/fzf' "Fuzzy file finder
Plug 'justinmk/vim-sneak' "f and t across lines
Plug 'rizzatti/dash.vim' "Integration with Dash (search docs)
Plug 'sbdchd/neoformat' "Autoformatting
Plug 'tpope/vim-commentary' "Toggle comments
Plug 'tpope/vim-repeat' "Handles repeating plugin commands as a whole
Plug 'tpope/vim-sensible' "Set some sensible defaults
Plug 'tpope/vim-surround' "Add/change/remove surrounding brackets
Plug 'tpope/vim-vinegar' "Netrw enhancements
Plug 'windwp/nvim-autopairs' "Automatically insert matching brackets, and jump over them when typing them

call plug#end()

