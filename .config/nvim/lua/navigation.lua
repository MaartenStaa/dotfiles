local actions = require('telescope.actions')
local telescope = require('telescope')
telescope.setup({
  mappings = {
    i = {
      ['<C-k>'] = {
        actions = actions.move_selection_previous,
        opts = { nowait = true, silent = true }
      },
      ['<C-j>'] = {
        actions = actions.move_selection_next,
        opts = { nowait = true, silent = true }
      },
    }
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case' -- options: ignore_case, respect_case, smart_case
    },
    ['ui-select'] = {
      require('telescope.themes').get_dropdown({

      })
    }
  }
})

telescope.load_extension('fzf')
telescope.load_extension('ui-select')

local builtin = require('telescope.builtin')
vim.keymap.set({ 'n', 'v', 'o' }, '<C-p>', builtin.find_files)
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>ff', builtin.find_files)
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>fg', builtin.live_grep)
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>fb', builtin.buffers)
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>gd', builtin.lsp_definitions)
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>gl', function() builtin.diagnostics({ bufnr = 0 }) end)
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>gr', builtin.lsp_references)
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>gi', builtin.lsp_implementations)
vim.keymap.set({ 'n', 'v', 'o' }, '<Leader>ga', builtin.builtin)

telescope.load_extension('refactoring')
vim.keymap.set(
  "n",
  "<leader>rr",
  "viw<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
  -- function()
  --   vim.k
  --   vim.cmd [[packadd packer.nvim]]
  -- end,
  { noremap = true}
)
vim.keymap.set(
    "v",
    "<leader>rr",
    telescope.extensions.refactoring.refactors,
    --"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
    { noremap = true }
)
