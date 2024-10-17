local wk = require("which-key")

wk.add({
  -- <leader> keymaps
  { '<leader>b', desc = 'Toggle file tree' },
  { '<leader>d', group = 'debugging' },
  { '<leader>e', group = 'edit' },
  { '<leader>f', group = 'find' },
  { '<leader>g', group = 'go to' },
  { '<leader>h', group = 'git hunks' },
  { '<leader>hp', desc = 'Previous hunk' },
  { '<leader>hs', desc = 'Stage hunk' },
  { '<leader>hu', desc = 'Undo hunk' },
  { '<leader>r', group = 'rename' },
  { '<leader>t', group = 'tabs' },
  { '<leader>x', group = 'diagnostics' },

  -- g prefix
  { 'gc', desc = 'Toggle comment' },

  -- no prefix
  { '<leader>', group = 'custom shortcuts' },
  { '[', group = 'jump backward' },
  { ']', group = 'jump forward' },
  { 'S', desc = 'Leap backward to' },
  { 's', desc = 'Leap forward to' },
  { 'X', desc = 'Leap backward until' },
  { 'x', desc = 'Leap forward until' },
  { 'z', group = 'folds' },
})
