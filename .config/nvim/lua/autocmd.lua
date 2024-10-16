-- Automatically source vimrc file on searching
local autosourcing = vim.api.nvim_create_augroup('autosourcing', { clear = true})
vim.api.nvim_create_autocmd('BufWritePost', {
  group = autosourcing,
  pattern = 'init.lua',
  command = 'source %'
})

-- Fix blade filetype not being set correctly.
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = autosourcing,
  pattern = '*.blade.php',
  command = 'set filetype=blade'
})

-- Set tabbing based on file type
vim.api.nvim_create_autocmd('FileType', {
  group = autosourcing,
  pattern = '*.blade',
  command = 'setlocal ts=2 sts=2 sw=2 expandtab' }
)
vim.api.nvim_create_autocmd('FileType', {
  group = autosourcing,
  pattern = '*.css',
  command = 'setlocal ts=4 sts=4 sw=4 expandtab' }
)
vim.api.nvim_create_autocmd('FileType', {
  group = autosourcing,
  pattern = '*.html',
  command = 'setlocal ts=2 sts=2 sw=2 expandtab' }
)
vim.api.nvim_create_autocmd('FileType', {
  group = autosourcing,
  pattern = '*.js',
  command = 'setlocal ts=2 sts=2 sw=2 expandtab' }
)
vim.api.nvim_create_autocmd('FileType', {
  group = autosourcing,
  pattern = '*.lua',
  command = 'setlocal ts=2 sts=2 sw=2 expandtab' }
)
vim.api.nvim_create_autocmd('FileType', {
  group = autosourcing,
  pattern = '*.md',
  command = 'setlocal textwidth=80 spell' }
)
vim.api.nvim_create_autocmd('FileType', {
  group = autosourcing,
  pattern = '*.php',
  command = 'setlocal ts=4 sts=4 sw=4 expandtab' }
)
vim.api.nvim_create_autocmd('FileType', {
  group = autosourcing,
  pattern = '*.scss',
  command = 'setlocal ts=4 sts=4 sw=4 expandtab' }
)
vim.api.nvim_create_autocmd('FileType', {
  group = autosourcing,
  pattern = '*.sh',
  command = 'setlocal ts=2 sts=2 sw=2 expandtab' }
)
vim.api.nvim_create_autocmd('FileType', {
  group = autosourcing,
  pattern = '*.vim',
  command = 'setlocal ts=4 sts=4 sw=4 expandtab' }
)

-- Treat BUILD.out as a Bazel file
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = autosourcing,
  pattern = 'BUILD.out',
  command = 'set filetype=bzl'
})

-- Never hide git commit messages and such
vim.api.nvim_create_autocmd('FileType', {
  group = autosourcing,
  pattern = 'gitcommit,gitrebase,gitconfig,diff',
  command = 'set bufhidden=delete',
})

-- Open trouble window when quickfix window is opened
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = autosourcing,
  pattern = 'quickfix',
  callback = function()
    local ok, trouble = pcall(require, 'trouble')
    if ok then
      vim.defer_fn(function()
        vim.cmd('cclose')
        trouble.open('quickfix')
      end, 0)
    end
  end,
})
