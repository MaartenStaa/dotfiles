if (!exists('g:vscode'))
    so ~/.vim/plugins.vim
endif

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

syntax enable

set nocompatible
set backspace=indent,eol,start		"Make backspace behave normally
set cmdheight=2                     "Better display for messages
set linespace=12                    "Set line height (only for macvim)
let mapleader=','                   "Set comma as command namespace (leader)
set number                          "Enable line-numbers
"set macligatures                   "Enable font ligature support
set nobackup
set noswapfile
set nowritebackup
set relativenumber                  "Enable relative line-numbers
set redrawtime=5000                 "Allow more time to redraw before disabling syntax highlighting
set ts=4 sts=4 sw=4 expandtab       "Insert spaces for tabs
set rtp+=/usr/local/opt/fzf
set re=0                            "yats: Old regexp engine will incur performance issues for yats and old engine is usually turned on by other plugins.
set noshowmode                      "Already shown by lightline

"---------Searching---------"
set hlsearch                        "Enable search term highlighting
set incsearch                       "Incremental search
set ignorecase                      "Case-insensitive search

"-----Split management------"
set splitbelow
set splitright

nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

"----------Visuals----------"
"set t_CO=256
"set guifont=Fira_Code:h15
"set background=dark
set termguicolors
colorscheme onedark

set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

"----------Mappings----------"
nmap <Leader>env :tabedit ~/.config/nvim/init.vim<cr>
nmap <Leader>ep :tabedit ~/.vim/plugins.vim<cr>
"leaderleader -> switch between the last two files
nnoremap <Leader><Leader> <C-^>
"tc -> create tab
nmap <Leader>tc :tabnew<cr>
"tn -> next tab
nmap <Leader>tn :tabnext<cr>
nmap <C-Tab> :tabnext<cr>
"tp -> previous tab
nmap <Leader>tp :tabprevious<cr>
nmap <C-S-Tab> :tabprevious<cr>
"tw -> close tab
nmap <Leader>tw :tabclose<cr>
"to -> only tab
nmap <Leader>to :tabonly<cr>
"space -> end searching (get rid of highlights)
nmap <Leader><space> :nohlsearch<cr>
"b -> nerdtree toggle
nmap <Leader>b :NERDTreeToggle<cr>
"l -> toggle list
nmap <Leader>l :set list!<cr>:IndentGuidesToggle<cr>
"ctrl-shift-h -> search in dash
nmap <silent> <C-S-H> :Dash<cr>
"use H and L to go to the start and end of a line
nmap H ^
nmap L $
"; -> :
"nmap ; :
"s -> toggle spell check
nmap <Leader>s :setlocal spell!<cr>
"Use the sneak plugin to use f/F/t/T across lines
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
"Yank and Paste to system clipboard
nmap <Leader>y "+y
vmap <Leader>y "+y
nmap <Leader>p "+p
vmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>P "+P

"Go to stuff with Telescope
map <C-R> :Telescope lsp_document_symbols<cr>
map <C-P> :Telescope git_files<cr>
map <Leader>ff :Telescope git_files<cr>
map <Leader>fa :Telescope find_files<cr>
map <Leader>fg :Telescope live_grep<cr>
map <Leader>fb :Telescope buffers<cr>
map <Leader>gl :Telescope loclist<cr>

"Use tab for auto completion via LSP
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-TAB>        pumvisible() ? "\<C-p>" : "\<S-Tab>"

"Autocomplete settings
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect
inoremap <C-space> <C-x><C-o>

"Remap for format selected region
"vmap <leader>f <Plug>(coc-format-selected)
"nmap <leader>f <Plug>(coc-format-selected)
let g:neoformat_try_node_exe = 1 "Look for project Prettier install
let g:neoformat_only_msg_on_error = 1

"-----Invisible character-----"
set listchars=tab:»·,trail:·,nbsp:·,multispace:·,eol:$
highlight NonText guifg=#3b4048
highlight SpecialKey guifg=#3b4048

"-----Automatic commands----"
if has('autocmd')
    "Automatically source vimrc file on searching
    augroup autosourcing
        autocmd!
        autocmd BufWritePost plugins.vim source %
        autocmd BufWritePost init.vim source %
    augroup END

    "Fix blade filetype not being set correctly.
    autocmd BufRead,BufNewFile *.blade.php set filetype=blade

    "Set tabbing based on file type
    autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType scss setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType php setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType blade setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType vim setlocal ts=2 sts=2 sw=2 expandtab
endif

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor

    if !exists(":Ag")
        command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
        nnoremap \ :Ag<SPACE>
    endif
endif

let g:fzf_layout = { 'down': '40%' }
let g:fzf_action = {
            \ 'enter': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

"Lightline UI
let g:lightline = {
            \ 'active': {
            \   'left': [
            \     [ 'mode', 'paste' ],
            \     [ 'lsp_info', 'lsp_hints', 'lsp_errors', 'lsp_warnings', 'lsp_ok' ], [ 'lsp_status' ],
            \     [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'LightlineGitBranch'
            \ },
      \ }
function! LightlineGitBranch()
    return ' ' . gitbranch#name()
endfunction
"if lightline#
"  "Calling this again fixes lightline losing its colour upon sourcing this file
"  call lightline#colorscheme()
"endif
call lightline#lsp#register()

"-----Automatic commands----"
if has('autocmd')
    " Enable type inlay hints
    autocmd CursorHold,CursorHoldI * :lua require'lsp_extensions'.inlay_hints{ only_current_line = false }
endif

lua << EOF
  require("nvim-autopairs").setup({
    check_ts = true
  })
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')

  require("nvim-lsp-installer").setup({
    automatic_installation = true
  })

  require('neoscroll').setup()

  -- LSP configuration
  local lspconfig = require('lspconfig')
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- Navigations
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<Leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[c', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']c', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  end

  function merge(a, b)
      for k, v in pairs(b) do
          a[k] = v
      end
  
      return a
  end

  -- Add additional capabilities supported by nvim-cmp
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  local servers = {
    cssls = { cmd = { "css-languageserver", "--stdio" } },
    intelephense = {},
    sumneko_lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      filetypes = { 'lua', 'vim' },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        -- Do not send telemetry data containing a randomized but unique identifier
        enable = false,
      },
    },
    rust_analyzer = {},
    tsserver = { cmd = { "typescript-language-server", "--stdio" } },
    vimls = {}
  }
  for lsp, config in pairs(servers) do
    lspconfig[lsp].setup(merge({
      capabilities = capabilities,
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }, config))
  end

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = true,
      signs = true,
      update_in_insert = true,
    }
  )

  -- Autocompletion (nvim-cmp)
  local cmp = require'cmp'
  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

  require 'lsp_signature'.setup({})

  -- Treesitter
  require'nvim-treesitter.configs'.setup({
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = {},  -- list of language that will be disabled
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
  })
  require'nvim-treesitter.configs'.setup {
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
        },
      },
    },
  }

  local actions = require('telescope.actions')
  require('telescope').setup {
    mappings = {
      i = {
        ["<C-k>"] = {
          action = actions.move_selection_previous,
          opts = { nowait = true, silent = true }
        },
        ["<C-j>"] = {
          action = actions.move_selection_next,
          opts = { nowait = true, silent = true }
        },
      }
    },
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                         -- the default case_mode is "smart_case"
      }
    }
  }
  require('telescope').load_extension('fzf')
EOF
