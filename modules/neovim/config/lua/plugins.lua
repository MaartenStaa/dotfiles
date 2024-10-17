-- Automatically bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- vim.cmd([[
--   augroup lazy_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | Lazy sync
--   augroup end
-- ]])

return require('lazy').setup({
  -- Theming
  {
    'catppuccin/nvim',
    lazy = false,
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require'catppuccin'.setup({
        flavour = 'macchiato',

        -- Enable support for some plugins
        fzf = true,
        indent_blankline = {
          enabled = true,
        },
        leap = true,
        mason = true,
        noice = true,
        cmp = true,
        dap = true,
        dap_ui = true,
        gitgutter = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
            ok = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        nvim_notify = true,
        treesitter_context = true,
        treesitter = true,
        which_key = true,
      })

      vim.cmd.colorscheme('catppuccin')
    end
  },
  -- 'doums/darcula',
  -- 'mofiqul/dracula.nvim',
  -- 'rktjmp/lush.nvim',
  -- 'skielbasa/vim-material-monokai',

  -- Language support
  '2072/php-indenting-for-vim',
  'b0o/schemastore.nvim',
  'editorconfig/editorconfig-vim',
  'fladson/vim-kitty',
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  'qnighy/lalrpop.vim',
  'sheerun/vim-polyglot',

  -- LSP & autocomplete
  'andersevenrud/cmp-tmux',
  {
    'github/copilot.vim',
    config = function ()
      vim.g.copilot_filetypes = { markdown = true, yaml = true }
    end,
  },
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'sirver/ultisnips' }
  },
  'neovim/nvim-lspconfig',
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  'nvim-lua/lsp_extensions.nvim',
  'nvim-treesitter/nvim-treesitter-textobjects',
  {
    'ray-x/lsp_signature.nvim',
    config = true,
    enabled = false,
  },
  -- 'williamboman/mason.nvim',
  -- 'williamboman/mason-lspconfig.nvim',

  -- UI enhancements
  -- Highlight other uses of item under cursor
  {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure({
        providers = {
          'lsp',
          'treesitter'
        },
        delay = 10,
        under_cursor = true
      })
    end
  },
  'airblade/vim-gitgutter',
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    opts = {
      default_mappings = true,
      default_commands = true,
      list_opener = 'Trouble',
    },
  },
  {
    'f-person/git-blame.nvim',
    config = function()
      vim.g.gitblame_set_extmark_options = {
        hl_mode = "combine",
      }
      vim.g.gitblame_ignored_filetypes = { 'terminal', '', 'toggleterm' }
    end
  },
  {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      cmdline = {
        -- view = 'cmdline',
      },
      messages = {
        enabled = false,
        view_search = false,
      },
    },
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      height = 20,
      use_diagnostic_signs = true,
    },
  },
  {
    'folke/which-key.nvim',
    dependencies = { 'echasnovski/mini.icons' },
     event = "VeryLazy",
     init = function()
       vim.o.timeout = true
       vim.o.timeoutlen = 500
     end,
     opts = {
       plugin = {
         presets = {
           motions = false,
         },
       },
     },
  },
  'junegunn/goyo.vim', -- Distraction free mode
  {
    'karb94/neoscroll.nvim',
    config = true
  },
  'nvim-tree/nvim-web-devicons',
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      vim.opt.list = true
      vim.opt.listchars:append "lead:⋅"
      vim.opt.listchars:append "trail:⋅"
      -- vim.opt.listchars:append "eol:↴"
      require('ibl').setup({
        indent = { char = '┊', }, -- can add: highlight = highlight, here too
        -- space_char_blankline = " ",
        -- show_current_context = true,
        -- show_current_context_start = true
      })
    end
  },
  'machakann/vim-highlightedyank',
  'markonm/traces.vim', -- Preview for substitutions
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup({
        enable = true,
        max_lines = 8
      })
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      { 'arkav/lualine-lsp-progress' },
      { 'dokwork/lualine-ex' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-tree/nvim-web-devicons', opt = true },
    },
    config = function ()
      local function get_modified()
        -- if utils.get_buf_option "mod" then
        --   local mod = icons.git.Mod
        --   return "%#WinBarFilename#" .. mod .. " " .. "%t" .. "%*"
        -- end
        return "%#WinBarFilename#" .. "%t" .. "%*"
      end

      local function get_winbar()
        return "%#WinBarSeparator#" .. "%=" .. "" .. "%*" .. get_modified() .. "%#WinBarSeparator#" .. "" .. "%*"
      end

      local icons = require('nvim-web-devicons')
      local cssmodules_icon, cssmodules_color = icons.get_icon_by_filetype('css')
      local eslint_icon, eslint_color = icons.get_icon('.eslintrc')
      local tsserver_icon, tsserver_color = icons.get_icon_by_filetype('typescript')

      -- icon_data {
      --   color = "#42a5f5",
      --   cterm_color = "75",
      --   icon = "",
      --   name = "Css"
      -- }
      -- "DevIconCss"
      local copilot_icon = ''
      local copilot_color = { fg = '#a373f7' }

      require('lualine').setup({
        options = {
          theme = 'catppuccin',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            winbar = {
              'help',
              'NvimTree',
              'toggleterm',
              'Trouble',
            },
          },
        },
        sections = {
          lualine_c = {
            { 'filename', path = 1 },
            {
              'ex.lsp.all',
              only_attached = true,
              icons = {
                ["GitHub Copilot"] = { copilot_icon, color = copilot_color },
                cssmodules_ls = { cssmodules_icon, color = cssmodules_color },
                eslint = { eslint_icon, color = eslint_color },
                tsserver = { tsserver_icon, color = tsserver_color },
              }
            },
            'lsp_progress',
          },
        },
        inactive_sections = {
          lualine_c = { { 'filename', path = 1 } }
        },
        -- winbar = {
        --   lualine_a = { 'diagnostics' },
        --   lualine_b = { '%#WinBarSeparator#' .. '%*' .. '%#WinBarFilename#' .. '%t' .. '%*' .. '%#WinBarSeparator#' },
        --   lualine_c = {},
        --   lualine_x = {},
        --   lualine_y = {},
        --   lualine_z = {},
        -- },
        -- inactive_winbar = {
        --   lualine_a = {},
        --   lualine_b = {},
        --   lualine_c = {},
        --   lualine_x = {},
        --   lualine_y = {},
        --   lualine_z = {},
        -- },
      })
    end
  },
  {
    'petertriho/nvim-scrollbar',
    config = true
  },
  -- 'romgrk/barbar.nvim',
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  -- {
  --   'yorickpeterse/nvim-pqf',
  --   config = true
  -- },

  -- Refactoring
  -- {
  --   'ThePrimeagen/refactoring.nvim',
  --   dependencies = {
  --     { 'nvim-lua/plenary.nvim' },
  --     { 'nvim-treesitter/nvim-treesitter' }
  --   },
  --   config = true
  -- }

  -- For easy navigation
  -- {
  --   'Dkendal/nvim-treeclimber',
  --   config = true,
  -- },
  {
    'ggandor/leap.nvim',
    keys = { 's', 'S', 'gs', 'X' },
    config = function ()
      require('leap').add_default_mappings()
    end
  },
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
      local fzf = require('fzf-lua')
      local actions = require 'fzf-lua.actions'

      fzf.register_ui_select()
      fzf.setup({
        actions = {
          files = {
            ['default'] = actions.file_edit_or_qf,
            ['ctrl-s']  = actions.file_split,
            ['ctrl-v']  = actions.file_vsplit,
            ['ctrl-t']  = actions.file_tabedit,
            ['ctrl-q']  = actions.file_sel_to_qf,
            ['ctrl-l']  = actions.file_sel_to_ll,
          }
        },
        commands = { sort_lastused = true },
        git = {
          files = {
            cmd = 'git ls-files --cached --others --exclude-standard',
          },
        },
      })
    end
  },

  -- Debugging
  'mfussenegger/nvim-dap',
  { 'mxsdev/nvim-dap-vscode-js', dependencies = { 'mfussenegger/nvim-dap' } },
  {
    'microsoft/vscode-js-debug',
    lazy = true,
    build = 'npm install --legacy-peer-deps && npm run compile && git checkout package-lock.json'
  }, -- For nvim-dap-vscode-js
  { 'rcarriga/nvim-dap-ui', dependencies = { 'nvim-neotest/nvim-nio' } },
  {
    'theHamsta/nvim-dap-virtual-text',
    branch = 'inline-text',
    config = true,
  },

  -- Productivity
  -- {
  --   "jake-stewart/multicursor.nvim",
  --   branch = "1.0",
  --   config = function()
  --     local mc = require("multicursor-nvim")

  --     mc.setup()

  --     -- Add cursors above/below the main cursor.
  --     vim.keymap.set({ "n", "v" }, "<up>", function() mc.addCursor("k") end)
  --     vim.keymap.set({ "n", "v" }, "<down>", function() mc.addCursor("j") end)

  --     -- Add a cursor and jump to the next word under cursor.
  --     vim.keymap.set({ "n", "v" }, "<c-n>", function() mc.addCursor("*") end)

  --     -- Jump to the next word under cursor but do not add a cursor.
  --     vim.keymap.set({ "n", "v" }, "<c-s>", function() mc.skipCursor("*") end)

  --     -- Rotate the main cursor.
  --     vim.keymap.set({ "n", "v" }, "<left>", mc.nextCursor)
  --     vim.keymap.set({ "n", "v" }, "<right>", mc.prevCursor)

  --     -- Delete the main cursor.
  --     vim.keymap.set({ "n", "v" }, "<leader>x", mc.deleteCursor)

  --     -- Add and remove cursors with control + left click.
  --     vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)

  --     vim.keymap.set({ "n", "v" }, "<c-q>", function()
  --       if mc.cursorsEnabled() then
  --         -- Stop other cursors from moving.
  --         -- This allows you to reposition the main cursor.
  --         mc.disableCursors()
  --       else
  --         mc.addCursor()
  --       end
  --     end)

  --     vim.keymap.set({ "n", "v" }, "<esc>", function()
  --       print(mc.cursorsEnabled(), mc.hasCursors())
  --       if not mc.cursorsEnabled() then
  --         mc.enableCursors()
  --       elseif mc.hasCursors() then
  --         mc.clearCursors()
  --       else
  --         -- Default <esc> handler.
  --       end
  --     end)

  --     -- Align cursor columns.
  --     vim.keymap.set("n", "<leader>a", mc.alignCursors)

  --     -- Split visual selections by regex.
  --     vim.keymap.set("v", "S", mc.splitCursors)

  --     -- Append/insert for each line of visual selections.
  --     vim.keymap.set("v", "I", mc.insertVisual)
  --     vim.keymap.set("v", "A", mc.appendVisual)

  --     -- match new cursors within visual selections by regex.
  --     vim.keymap.set("v", "M", mc.matchCursors)

  --     -- Rotate visual selection contents.
  --     vim.keymap.set("v", "<leader>t", function() mc.transposeCursors(1) end)
  --     vim.keymap.set("v", "<leader>T", function() mc.transposeCursors(-1) end)

  --     -- Customize how cursors look.
  --     vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
  --     vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
  --     vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
  --     vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
  --   end,
  -- },

  -- Misc
  {
    -- Add/change/remove surrounding brackets
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = true,
  },
  {
    -- Automatically track sessions per directory
    'Shatur/neovim-session-manager',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('session_manager').setup({
        autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir,
        autosave_only_in_session = false
      })
    end
  },
  {
    -- Integration with Dash (search docs)
    'maartenstaa/dash.nvim',
    build = 'make install',
    keys = {
      { '<Leader>h', '<cmd>DashWord<CR>' }
    },
    opts = {
      search_engine = 'startpage',
      file_type_keywords = {
        javascript = { 'js', 'nodejs' },
        typescript = { 'typescript', 'js', 'nodejs' },
        typescriptreact = { 'typescript', 'js', 'react' },
        javascriptreact = { 'js', 'react' },
        python = { 'python', 'python3' },
      },
    },
  },
  {
    -- Autoformatting
    'sbdchd/neoformat',
    config = function()
      -- Look for project Prettier install
      vim.g.neoformat_try_node_exe = 1
      vim.g.neoformat_only_msg_on_error = 1

      -- Tweak autopep8 configuration
      vim.g.neoformat_python_autopep8 = {
        exe = 'autopep8',
        args = { '-', '--max-line-length', '100' },
        stdin = 1,
      }
      vim.g.neoformat_enabled_python = { 'autopep8' }

      local augroup = vim.api.nvim_create_augroup('fmt', { clear = true })
      vim.api.nvim_create_autocmd('BufWritePre', {
        command = 'try | undojoin | Neoformat | catch /E790/ | Neoformat | endtry',
        group = augroup
      })
    end
  },
  'schickling/vim-bufonly', -- Add :BufOnly command
  'tpope/vim-commentary', -- Toggle comments
  'tpope/vim-repeat', -- Handles repeating plugin commands as a whole
  'tpope/vim-sensible', -- Set some sensible defaults
  -- 'tpope/vim-vinegar', -- Netrw enhancements
  {
    -- Automatically insert matching brackets, and jump over them when typing them
    'windwp/nvim-autopairs',
    config = function()
      local autopairs = require('nvim-autopairs')
      autopairs.setup({
        check_ts = true
      })

      local Rule = require('nvim-autopairs.rule')
      autopairs.add_rule(
        Rule("%<%>$", "</>", { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' })
        :use_regex(true)
      )
    end
  },
  'windwp/nvim-ts-autotag', -- And kind of the same for tags (HTML, JSX)
}, {
  install = {
    colorscheme = { 'onedark' }
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'netrwPlugin'
      }
    }
  },
  profile = {
    enable = true
  }
})
