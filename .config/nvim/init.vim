if (!exists('g:vscode'))
    so ~/.config/nvim/plugins.vim
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
set mouse=nv                        "Allow mouse usage in normal and visual modes

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
set cursorline

set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

"----------Mappings----------"
nmap <Leader>env :tabedit ~/.config/nvim/init.vim<cr>
nmap <Leader>enl :tabedit ~/.config/nvim/lua/init.lua<cr>
nmap <Leader>ep :tabedit ~/.config/nvim/plugins.vim<cr>
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
map <C-r> :Telescope lsp_document_symbols<cr>
map <C-p> :Telescope git_files<cr>
map <Leader>ff :Telescope git_files<cr>
map <Leader>fa :Telescope find_files<cr>
map <Leader>fg :Telescope live_grep<cr>
map <Leader>fb :Telescope buffers<cr>
map <Leader>gd :Telescope lsp_definitions<cr>
map <Leader>gl :Telescope diagnostics bufnr=0<cr>
map <Leader>gr :Telescope lsp_references<cr>
map <Leader>gi :Telescope lsp_implementations<cr>
map <Leader>ga :Telescope builtin<cr>

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
        autocmd BufWritePost init.lua source %
    augroup END

    augroup fmt
        autocmd!
        autocmd BufWritePre * undojoin | Neoformat
    augroup END

    "Fix blade filetype not being set correctly.
    autocmd BufRead,BufNewFile *.blade.php set filetype=blade

    "Set tabbing based on file type
    autocmd FileType blade setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType lua setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType php setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType scss setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType vim setlocal ts=4 sts=4 sw=4 expandtab
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
    let name = gitbranch#name()
    return name !=# '' ? ' ' . gitbranch#name() : ''
endfunction
if exists('*lightline#colorscheme')
  "Calling this again fixes lightline losing its colour upon sourcing this file
  call lightline#colorscheme()
endif
call lightline#lsp#register()

"-----Automatic commands----"
if has('autocmd')
    " Enable type inlay hints
    autocmd CursorHold,CursorHoldI * :lua require'lsp_extensions'.inlay_hints{ only_current_line = false }
endif

"The rest is configured in LUA
lua require('init')
