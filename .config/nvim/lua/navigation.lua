local fzf = require('fzf-lua')
vim.keymap.set({ 'n', 'v', 'o' }, '<C-p>', fzf.files)
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>ff', fzf.files)
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>fg', function()
  fzf.live_grep({ cmd = "git grep --line-number --column --ignore-case --color=always --untracked" })
end)
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>fb', fzf.buffers)
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>fd', function() fzf.files({ cwd = "~/.config/nvim" }) end)
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>gd', function() fzf.lsp_definitions({ jump_to_single_result = true }) end)
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>gl', fzf.diagnostics_document)
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>gr', fzf.lsp_references)
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>gi', fzf.lsp_implementations)
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>ga', fzf.builtin)
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>gs', fzf.lsp_document_symbols)
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>fs', fzf.lsp_live_workspace_symbols)


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
