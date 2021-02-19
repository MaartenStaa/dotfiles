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
colorscheme material-monokai

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
"l -> toggle list
nmap <Leader>l :set list!<cr>:IndentGuidesToggle<cr>
"ctrl-shift-r -> search in dash
nmap <silent> <C-S-H> :Dash<cr>
"; -> :
"nmap ; :
"s -> toggle spell check
nmap <Leader>s :setlocal spell!<cr>

"use space and ctrl-space for page down and page up
nmap <space> <PageDown>
nmap <NUL> <PageUp>

"Use tab for auto completion in coc
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

"Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
"Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

"Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim', 'help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif has('CocAction')
        call CocAction('doHover')
    endif
endfunction

if has('CocActionAsync')
    "Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')
endif

"Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

"Show auto-fix options
nmap <leader>q :CocFix<cr>

"Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>p  :Prettier<cr>

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

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag --literal --files-with-matches --nocolor --hidden -g "" %s'

    " ag is fast enough that CtrlP doesn't need to cache
    "let g:ctrlp_use_caching = 1

    if !exists(":Ag")
        command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
        nnoremap \ :Ag<SPACE>
    endif
endif

