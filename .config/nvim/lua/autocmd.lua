-- Automatically source vimrc file on searching
local autosourcing = vim.api.nvim_create_augroup('autosourcing', { clear = true})
vim.api.nvim_create_autocmd('BufWritePost', {
  group = autosourcing,
  pattern = 'init.lua',
  command = 'source %'
})

-- Fix blade filetype not being set correctly.
vim.api.nvim_create_autocmd('BufRead,BufNewFile', {
  pattern = '*.blade.php',
  command = 'set filetype=blade'
})

-- Set tabbing based on file type
vim.api.nvim_create_autocmd('FileType', { pattern = '*.blade', command = 'setlocal ts=2 sts=2 sw=2 expandtab' })
vim.api.nvim_create_autocmd('FileType', { pattern = '*.css', command = 'setlocal ts=4 sts=4 sw=4 expandtab' })
vim.api.nvim_create_autocmd('FileType', { pattern = '*.html', command = 'setlocal ts=2 sts=2 sw=2 expandtab' })
vim.api.nvim_create_autocmd('FileType', { pattern = '*.javascript', command = 'setlocal ts=2 sts=2 sw=2 expandtab' })
vim.api.nvim_create_autocmd('FileType', { pattern = '*.lua', command = 'setlocal ts=2 sts=2 sw=2 expandtab' })
vim.api.nvim_create_autocmd('FileType', { pattern = '*.php', command = 'setlocal ts=4 sts=4 sw=4 expandtab' })
vim.api.nvim_create_autocmd('FileType', { pattern = '*.scss', command = 'setlocal ts=4 sts=4 sw=4 expandtab' })
vim.api.nvim_create_autocmd('FileType', { pattern = '*.vim', command = 'setlocal ts=4 sts=4 sw=4 expandtab' })

-- Never hide git commit messages and such
vim.api.nvim_create_autocmd('FileType', { pattern = 'gitcommit,gitrebase,gitconfig,diff', command = 'set bufhidden=delete' })
