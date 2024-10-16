-- Navigate between windows
vim.keymap.set('n', '<C-J>', '<C-W><C-J>', { noremap = true, desc = 'Jump to window below'})
vim.keymap.set('n', '<C-K>', '<C-W><C-K>', { noremap = true, desc = 'Jump to window above'})
vim.keymap.set('n', '<C-H>', '<C-W><C-H>', { noremap = true, desc = 'Jump to window on the left'})
vim.keymap.set('n', '<C-L>', '<C-W><C-L>', { noremap = true, desc = 'Jump to window on the right'})

-- Mappings
vim.keymap.set('n', '<Leader>enl', ':tabedit ~/.config/nvim/init.lua<cr>', { noremap = true, desc = 'Edit Neovim config' })
vim.keymap.set('n', '<Leader>ep', ':tabedit ~/.config/nvim/lua/plugins.lua<cr>', { noremap = true, desc = 'Edit plugins configuration' })
-- leaderleader -> switch between the last two files
vim.keymap.set('n', '<Leader><Leader>', '<C-^>', { noremap = true, desc = 'Switch between the last two files' })
-- c -> end searching (get rid of highlights)
vim.keymap.set({ 'n', 'v' }, '<Leader>c', ':nohlsearch<cr>', { silent = true, noremap = true, desc = 'Clear search highlights' })
vim.keymap.set('n', '<Leader>c', ':nohlsearch<cr>', { silent = true, noremap = true, desc = 'Clear search highlights' })
-- l -> toggle list
-- vim.keymap.set('n', '<Leader>l', ':set list!<cr>:IndentGuidesToggle<cr>', { noremap = true })
-- use H and L to go to the start and end of a line
vim.keymap.set('n', 'H', '^', { noremap = true, desc = 'Go to the start of the line' })
vim.keymap.set('n', 'L', '$', { noremap = true, desc = 'Go to the end of the line' })
-- s -> toggle spell check
-- vim.keymap.set('n', '<Leader>s', ':setlocal spell!<cr>', { noremap = true })
-- Yank and Paste to system clipboard
vim.keymap.set({ 'n', 'v' }, '<Leader>y', '"+y', { noremap = true, desc = 'Yank to system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<Leader>yf', ':let @+ = expand("%")<cr>', { noremap = true, silent = true, desc = 'Yank file path to system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<Leader>p', '"+p', { noremap = true, desc = 'Paste from system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<Leader>P', '"+P', { noremap = true, desc = 'Paste from system clipboard (before)' })
-- delete/save buffers easily
vim.keymap.set('n', '<leader>w', ':bd<cr>', { noremap = true, silent = true, desc = 'Delete current buffer' })
vim.keymap.set('n', '<leader>s', ':w<cr>', { noremap = true, silent = true, desc = 'Save current buffer' })
vim.keymap.set('n', '<leader>?', '/\\v(<c-r>=expand("<cword>")<cr>)/', { noremap = true, silent = true, desc = 'Start search matching current word' })

-- Use tab for auto completion via LSP
-- vim.keymap.set('i', '<Tab>', '<Cmd>if pumvisible() then<CR><C-n>else<CR><Tab>fi<CR>', { silent = true, expr = true })
-- vim.keymap.set('i', '<S-Tab>', '<Cmd>if pumvisible() then<CR><C-p>else<CR><S-Tab>fi<CR>', { silent = true, expr = true })

-- Autocomplete settings
vim.keymap.set('i', '<C-space>', '<C-x><C-o>', { noremap = true, desc = 'Trigger autocomplete' })

-- Move visual selection up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = 'Move visual selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = 'Move visual selection up' })

-- Join lines but keep cursor in the same place
vim.keymap.set('n', 'J', 'mzJ`z', { noremap = true, silent = true, desc = 'Join lines' })

-- Keep cursor in the middle while paging up and down
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true, desc = 'Page down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true, desc = 'Page up' })

-- Trouble list
vim.keymap.set('n', '<leader>xx', function() require('trouble').open() end, { noremap = true, silent = true, desc = 'Open trouble list' })
vim.keymap.set('n', '<leader>xw', function() require('trouble').open('workspace_diagnostics') end, { noremap = true, silent = true, desc = 'Open workspace diagnostics' })
vim.keymap.set('n', '<leader>xd', function() require('trouble').open('document_diagnostics') end, { noremap = true, silent = true, desc = 'Open document diagnostics' })
vim.keymap.set('n', '<leader>xd', function() require('trouble').open('document_diagnostics') end, { noremap = true, silent = true, desc = 'Open document diagnostics' })
vim.keymap.set('n', '<leader>xl', function() require('trouble').open('loclist') end, { noremap = true, silent = true, desc = 'Open loclist' })
vim.keymap.set('n', '<leader>xq', function() require('trouble').open('quickfix') end, { noremap = true, silent = true, desc = 'Open quickfix' })

-- Tabs
vim.keymap.set('n', '<leader>tn', ':tabnext<cr>', { noremap = true, silent = true, desc = 'Next tab' })
vim.keymap.set('n', '<leader>tp', ':tabprevious<cr>', { noremap = true, silent = true, desc = 'Previous tab' })
vim.keymap.set('n', '<leader>tw', ':tabclose<cr>', { noremap = true, silent = true, desc = 'Close tab' })

-- Quiet now (dismiss Noice messages)
vim.keymap.set({ 'n', 'v' }, '<leader>q', ':NoiceDismiss<cr>', { silent = true, desc = 'Dismiss Noice messages' })

-- Go to test for this file
vim.keymap.set('n', 'gt', function ()
  local filename = vim.fn.expand('%')
  if filename:find('[tj]sx?$') and not filename:find('\\.test\\.') then
    local extension = vim.fn.expand('%:e')
    local basename = filename:sub(1, filename:len() - extension:len())

    -- test file with same extension
    local testfile = string.format("%stest.%s", basename, extension)
    if vim.fn.filereadable(testfile) ~= 0 then
      print('a', vim.fn.filereadable(testfile))
      vim.cmd('e ' .. testfile)
      return
    end

    -- js file with ts test
    local tstestfile = string.format("%stest.ts", basename)
    print(extension, tstestfile)
    if extension == "js" then
      print(extension, tstestfile)
      if vim.fn.filereadable(tstestfile) ~= 0 then
        print('b')
        vim.cmd('e ' .. tstestfile)
        return
      end
    end
    print("not found")
  end
end, { noremap = true, silent = true, desc = 'Jump to test file' })

-- Allow entering normal mode in terminal more easily
-- vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {noremap=true})
