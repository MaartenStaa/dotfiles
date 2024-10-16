local fzf = require('fzf-lua')

local function fzf_files()
  local base = vim.fn.fnamemodify(vim.fn.expand('%'), ':h:.:S')
  local fd = 'fd --type f --strip-cwd-prefix --hidden'
  local icons = '~/.dotfiles/bin/file-web-devicon'
  local command
  if base == '.' then
    command = fd .. ' | ' .. icons
  else
    command = vim.fn.printf('%s | proximity-sort "%s" | %s', fd, vim.fn.expand('%'), icons)
  end

  fzf.fzf_exec(command, {
    actions = fzf.config.defaults.actions.files,
    fzf_opts = { ['--nth'] = 2, ['--delimiter'] = fzf.utils.nbsp, ['--tiebreak'] = 'index' },
    previewer = 'builtin',
  })
end

local function fzf_relative_files()
  local base = vim.fn.fnamemodify(vim.fn.expand('%'), ':h:.:S')
  print(base)

  fzf.fzf_exec('fd --type f --hidden . "' .. base .. '" | ~/.dotfiles/bin/file-web-devicon', {
    actions = fzf.config.defaults.actions.files,
    fzf_opts = { ['--nth'] = 2, ['--delimiter'] = fzf.utils.nbsp },
    previewer = 'builtin',
  })
end

local function fzf_all_files()
  fzf.fzf_exec('fd --type f --strip-cwd-prefix --hidden --no-ignore-vcs | ~/.dotfiles/bin/file-web-devicon', {
    actions = fzf.config.defaults.actions.files,
    fzf_opts = { ['--nth'] = 2, ['--delimiter'] = fzf.utils.nbsp, ['--tiebreak'] = 'index' },
    previewer = 'builtin',
  })
end

vim.keymap.set({ 'n', 'v', 'o' }, '<C-p>', fzf_files, { desc = 'Find files' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>ff', fzf_files, { desc = 'Find files' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>fr', fzf_relative_files, { desc = 'Find files in directory of current file' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>fa', fzf_all_files, { desc = 'Find all files' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>fg', function()
  fzf.live_grep({ cmd = "git grep --line-number --column --ignore-case --color=always --untracked", git_icons = false })
end, { desc = 'Find in files' })
vim.keymap.set({ 'n' }, '<Leader>fw', fzf.grep_cword, { desc = 'Find word under cursor' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>fb', fzf.buffers, { desc = 'Find open buffers' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>fd', function() fzf.files({ cwd = "~/.config/nvim" }) end, { desc = 'Find files in nvim config' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>gl', fzf.diagnostics_document, { desc = 'Find diagnostics in the current document' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>gw', fzf.diagnostics_workspace, { desc = 'Find diagnostics in the entire workspace' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>ga', fzf.builtin, { desc = 'Go to anything' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>gs', fzf.lsp_document_symbols, { desc = 'Find symbols in the current document' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>fs', fzf.lsp_live_workspace_symbols, { desc = 'Find symbols in the current workspace' })
vim.keymap.set({ 'n', 'v', 'o' }, 'gd', function() fzf.lsp_definitions({ jump_to_single_result = true }) end, { desc = 'Go to definition' })
vim.keymap.set({ 'n', 'v', 'o' }, 'gr', fzf.lsp_references, { desc = 'Find references' })
vim.keymap.set({ 'n', 'v', 'o' }, 'gi', fzf.lsp_implementations, { desc = 'Find implementations' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>gp', fzf.resume, { desc = 'Resume last FZF command' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>gh', fzf.help_tags, { desc = 'Find help tags' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>/', fzf.grep_curbuf, { desc = 'Find in current buffer' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>;', fzf.commands, { desc = 'Find commands' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>t', fzf.tags, { desc = 'Find tags' })

-- telescope.load_extension('refactoring')
--vim.keymap.set(
--  "n",
--  "<leader>rr",
--  "viw<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
--  -- function()
--  --   vim.k
--  --   vim.cmd [[packadd packer.nvim]]
--  -- end,
--  { noremap = true}
--)
--vim.keymap.set(
--    "v",
--    "<leader>rr",
--    telescope.extensions.refactoring.refactors,
--    --"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
--    { noremap = true }
--)
