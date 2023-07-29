vim.opt.cmdheight = 2  -- Better display for messages
vim.opt.linespace = 12 -- Set line height (only for macvim)
vim.opt.number = true  -- Enable line-numbers
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.relativenumber = true                          -- Enable relative line-numbers
vim.opt.redrawtime = 5000                              -- Allow more time to redraw before disabling syntax highlighting
vim.opt.ts = 4
vim.opt.sts = 4
vim.opt.sw = 4
vim.opt.expandtab = true
vim.opt.rtp:append('/usr/local/opt/fzf')
vim.opt.re = 0                                         -- yats: Old regexp engine will incur performance issues for yats and old engine is usually turned on by other plugins.
vim.opt.showmode = false                              -- Already shown by lualine
vim.opt.mouse = 'nv'                                   -- Allow mouse usage in normal and visual modes
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir' -- Persistent undo history
vim.opt.undofile = true
vim.opt.scrolloff = 8                                  -- Leave more room between cursor line and top/bottom of screen
vim.opt.colorcolumn = '81,121,+1'

-- Searching
vim.opt.hlsearch = true   -- Enable search term highlighting
vim.opt.incsearch = true  -- Incremental search
vim.opt.ignorecase = true -- Case-insensitive search
if vim.fn.executable('ag') == 1 then
  vim.g.grepprg='ag --nogroup --nocolor'
end

-- Split management
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Visuals
vim.opt.termguicolors = true
vim.opt.cursorline = true

-- Autocomplete settings
--  menuone: popup even when there's only one match
--  noinsert: Do not insert text until a selection is made
--  noselect: Do not select, force user to select one from the menu
vim.opt.completeopt = 'menuone,noinsert,noselect'

-- To prevent nested nvim instances (see also autocmd to prevent hidden git buffers)
vim.env.GIT_EDITOR = 'nvr -cc split --remote-wait'
