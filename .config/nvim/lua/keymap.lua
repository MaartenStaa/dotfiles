vim.g.mapleader = ','  -- Set comma as command namespace (leader)

-- Navigate between windows
vim.keymap.set('n', '<C-J>', '<C-W><C-J>', { noremap = true })
vim.keymap.set('n', '<C-K>', '<C-W><C-K>', { noremap = true })
vim.keymap.set('n', '<C-H>', '<C-W><C-H>', { noremap = true })
vim.keymap.set('n', '<C-L>', '<C-W><C-L>', { noremap = true })

-- Mappings
vim.keymap.set('n', '<Leader>env', ':tabedit ~/.config/nvim/init.vim<cr>', { noremap = true })
vim.keymap.set('n', '<Leader>enl', ':tabedit ~/.config/nvim/lua/init.lua<cr>', { noremap = true })
vim.keymap.set('n', '<Leader>ep', ':tabedit ~/.config/nvim/lua/plugins.lua<cr>', { noremap = true })
-- leaderleader -> switch between the last two files
vim.keymap.set('n', '<Leader><Leader>', '<C-^>', { noremap = true })
-- tc -> create tab
vim.keymap.set('n', '<Leader>tc', ':tabnew<cr>', { noremap = true })
-- tn -> next tab
vim.keymap.set('n', '<Leader>tn', ':tabnext<cr>', { noremap = true })
vim.keymap.set('n', '<C-Tab>', ':tabnext<cr>', { noremap = true })
-- tp -> previous tab
vim.keymap.set('n', '<Leader>tp', ':tabprevious<cr>', { noremap = true })
vim.keymap.set('n', '<C-S-Tab>', ':tabprevious<cr>', { noremap = true })
-- tw -> close tab
vim.keymap.set('n', '<Leader>tw', ':tabclose<cr>', { noremap = true })
-- to -> only tab
vim.keymap.set('n', '<Leader>to', ':tabonly<cr>', { noremap = true })
-- space -> end searching (get rid of highlights)
vim.keymap.set('n', '<Leader><space>', ':nohlsearch<cr>', { noremap = true })
-- l -> toggle list
-- vim.keymap.set('n', '<Leader>l', ':set list!<cr>:IndentGuidesToggle<cr>', { noremap = true })
-- use H and L to go to the start and end of a line
vim.keymap.set('n', 'H', '^', { noremap = true })
vim.keymap.set('n', 'L', '$', { noremap = true })
-- s -> toggle spell check
vim.keymap.set('n', '<Leader>s', ':setlocal spell!<cr>', { noremap = true })
-- Yank and Paste to system clipboard
vim.keymap.set('n', '<Leader>y', '"+y', { noremap = true })
vim.keymap.set('v', '<Leader>y', '"+y', { noremap = true })
vim.keymap.set('n', '<Leader>p', '"+p', { noremap = true })
vim.keymap.set('v', '<Leader>p', '"+p', { noremap = true })
vim.keymap.set('n', '<Leader>P', '"+P', { noremap = true })
vim.keymap.set('v', '<Leader>P', '"+P', { noremap = true })
-- delete buffers easily
vim.keymap.set('n', '<leader>w', ':bd<cr>', { noremap = true })

-- Use tab for auto completion via LSP
vim.keymap.set('i', '<Tab>', '<Cmd>if pumvisible() then<CR><C-n>else<CR><Tab>fi<CR>', { silent = true, expr = true })
vim.keymap.set('i', '<S-Tab>', '<Cmd>if pumvisible() then<CR><C-p>else<CR><S-Tab>fi<CR>', { silent = true, expr = true })

-- Autocomplete settings
vim.keymap.set('i', '<C-space>', '<C-x><C-o>', { noremap = true })

-- Move visual selection up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Join lines but keep cursor in the same place
vim.keymap.set('n', 'J', 'mzJ`z')

-- Keep cursor in the middle while paging up and down
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
