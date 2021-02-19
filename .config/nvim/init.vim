
"node is an alias to initialize nvm, so specify node path
let g:coc_node_path = '/Users/maarten/.nvm/versions/node/v10.15.0/bin/node'

if (!exists('g:vscode'))
    so ~/.vim/plugins.vim
endif

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
