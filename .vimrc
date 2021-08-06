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
set t_CO=256
"set guifont=Fira_Code:h15
set background=dark
set termguicolors
colorscheme darcula

set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

"----------Mappings----------"
"ev -> edit vimrc file
nmap <Leader>ev :tabedit ~/.vimrc<cr>
"leaderleader -> switch between the last two files
nnoremap <Leader><Leader> <C-^>
"tc -> create tab
nmap <Leader>tc :tabnew<cr>
"tn -> next tab
nmap <Leader>tn :tabnext<cr>
"tp -> previous tab
nmap <Leader>tp :tabprevious<cr>
"tw -> close tab
nmap <Leader>tw :tabclose<cr>
"to -> only tab
nmap <Leader>to :tabonly<cr>
"space -> end searching (get rid of highlights)
nmap <Leader><space> :nohlsearch<cr>
"b -> nerdtree toggle
nmap <Leader>b :NERDTreeToggle<cr>
"ctrl-r -> go to symbol
nmap <C-R> :CtrlPBufTag<cr>
nmap <C-P> :FZF<cr>
"l -> toggle list
nmap <Leader>l :set list!<cr>:IndentGuidesToggle<cr>
"ctrl-shift-r -> search in dash
nmap <silent> <C-S-H> :Dash<cr>
"; -> :
"nmap ; :
"s -> toggle spell check
nmap <Leader>s :setlocal spell!<cr>
"Use the sneak plugin to use f/F/t/T across lines
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

"use space and ctrl-space for page down and page up
nmap <space> <PageDown>
nmap <NUL> <PageUp>

"Use tab for auto completion via LSP
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<S-Tab>"
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
nmap <leader>p :Prettier<cr>

"-----Invisible character-----"
set listchars=tab:»·,trail:·,nbsp:·,space:·,eol:$
highlight NonText guifg=#3b4048
highlight SpecialKey guifg=#3b4048

"-----Automatic commands----"
if has('autocmd')
    "Automatically source vimrc file on searching
    augroup autosourcing
        autocmd!
        autocmd BufWritePost .vimrc source %
        autocmd BufWritePost plugins.vim source ~/.vimrc
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

