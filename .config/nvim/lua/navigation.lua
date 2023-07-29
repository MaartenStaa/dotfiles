local fzf = require('fzf-lua')

local function fzf_files()
  fzf.fzf_exec('fd --type f --strip-cwd-prefix | ~/.dotfiles/bin/file-web-devicon', {
    actions = fzf.defaults.actions.files,
    previewer = 'builtin',
  })
end

vim.keymap.set({ 'n', 'v', 'o' }, '<C-p>', fzf_files, { desc = 'Find files' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>ff', fzf_files, { desc = 'Find files' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>fg', function()
  fzf.live_grep({ cmd = "git grep --line-number --column --ignore-case --color=always --untracked" })
end, { desc = 'Find in files' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>fb', fzf.buffers, { desc = 'Find open buffers' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>fd', function() fzf.files({ cwd = "~/.config/nvim" }) end, { desc = 'Find files in nvim config' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>gl', fzf.diagnostics_document, { desc = 'Find diagnostics in the current document' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>ga', fzf.builtin, { desc = 'Go to anything' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>gs', fzf.lsp_document_symbols, { desc = 'Find symbols in the current document' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>fs', fzf.lsp_live_workspace_symbols, { desc = 'Find symbols in the current workspace' })
vim.keymap.set({ 'n', 'v', 'o' }, 'gd', function() fzf.lsp_definitions({ jump_to_single_result = true }) end, { desc = 'Go to definition' })
vim.keymap.set({ 'n', 'v', 'o' }, 'gr', fzf.lsp_references, { desc = 'Find references' })
vim.keymap.set({ 'n', 'v', 'o' }, 'gi', fzf.lsp_implementations, { desc = 'Find implementations' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>gp', fzf.resume, { desc = 'Resume last FZF command' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>gh', fzf.help_tags, { desc = 'Find help tags' })
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>/', fzf.grep_curbuf, { desc = 'Find in current buffer' })

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
