local wk = require("which-key")

-- <leader> keymaps
wk.register({
  b = 'Toggle file tree',
  d = {
    name = 'debugging',
  },
  e = {
    name = 'edit',
  },
  f = {
    name = 'find',
  },
  g = {
    name = 'go to',
  },
  h = {
    name = 'git hunks',
    p = 'Previous hunk',
    s = 'Stage hunk',
    u = 'Undo hunk',
  },
  r = {
    name = 'rename',
  },
  x = {
    name = 'diagnostics',
  },
}, { prefix = '<leader>' })

-- g prefix
wk.register({
  c = 'Toggle comment',
}, { prefix = 'g' })

-- no prefix
wk.register({
  ['<leader>'] = { name = 'custom shortcuts' },
  ['['] = { name = 'jump backward' },
  [']'] = { name = 'jump forward' },
  S = 'Leap backward to',
  s = 'Leap forward to',
  X = 'Leap backward until',
  x = 'Leap forward until',
  z = { name = 'folds' },
})
