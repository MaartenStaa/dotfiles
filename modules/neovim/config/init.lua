-- Set leader key first so plugin triggers can register correctly
vim.g.mapleader = ' '  -- Set space as command namespace (leader)

-- Plugins first
require 'plugins'

-- Then load everything
require 'autocmd'
require 'autocomplete'
require 'debugging'
require 'keymap'
require 'lsp'
require 'navigation'
require 'set'
require 'signs'
require 'terminal'
require 'treesitter'
require 'which'
