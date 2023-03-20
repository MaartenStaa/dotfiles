-- Set up LSP installer, manually adding the Relay LS.
local lsp_installer = require('nvim-lsp-installer')
local npm = require('nvim-lsp-installer.core.managers.npm')
lsp_installer.setup({
  automatic_installation = true
})
local relay_install_dir = require('nvim-lsp-installer.core.path').concat({
  require('nvim-lsp-installer.settings').current.install_root_dir,
  'relay',
})
lsp_installer.register(require('nvim-lsp-installer.server').Server:new {
  name = 'relay',
  root_dir = relay_install_dir,
  languages = { 'graphql', 'typescriptreact' },
  homepage = 'https://github.com/facebook/relay',
  installer = npm.packages { 'relay-compiler' },
  default_options = {
    cmd_env = npm.env(relay_install_dir),
  },
})

-- LSP configuration
local lspconfig = require('lspconfig')
local on_attach = function(client, bufnr)
  -- Mappings.
  local opts = { buffer = bufnr, noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<Leader>a', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[c', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']c', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<Leader>f', function() vim.lsp.buf.format({ async = true }) end, opts)

  vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, opts)
end

local function merge(a, b)
  for k, v in pairs(b) do
    a[k] = v
  end

  return a
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Reference: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local lsp_configs = require('lspconfig.configs')
if not lsp_configs.relay then
  lsp_configs.relay = {
    default_config = {
      cmd = { 'relay-compiler', 'lsp' },
      filetypes = { 'graphq', 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact',
        'typescript.tsx' },
      root_dir = function(fname)
        local util = require('lspconfig.util')
        return util.root_pattern('relay.config.json')(fname)
            or util.root_pattern('package.json', '.git')(fname)
      end,
    },
  }
end

local servers = {
  bashls = {},
  cssls = {},
  cssmodules_ls = {},
  dockerls = {},
  eslint = {
    filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx',
      'vue', 'svelte', 'astro' }
  },
  gopls = {},
  intelephense = {},
  jdtls = {},
  jedi_language_server = {},
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file('', true),
        },
        telemetry = {
          -- Do not send telemetry data containing a randomized but unique identifier
          enable = false,
        },
      },
    },
  },
  marksman = {},
  relay = {},
  starlark_rust = {
    cmd = { '/Users/maartens/repos/github/facebookexperimental/starlark-rust/target/release/starlark', '--lsp'}
  },
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          allFeatures = true,
          overrideCommand = {
            'cargo', 'clippy', '--workspace', '--message-format=json', '--all-targets', '--all-features',
          }
        },
        procMacro = {
          enable = true,
          attributes = {
            enable = true
          }
        }
      }
    }
  },
  tsserver = {},
  vimls = {},
  yamlls = {
    settings = {
      yaml = {
        customTags = {
          '!BlockList mapping',
          '!Enrichment mapping',
          '!Location mapping',
          '!HealthcheckConfig mapping',
          '!PathMatcher mapping',
          '!Vertical mapping',
          '!VerticalGroup mapping',
        }
      }
    }
  }
}
for lsp, config in pairs(servers) do
  lspconfig[lsp].setup(merge({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }, config))
end

-- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics,
--   {
--     virtual_text = true,
--     signs = true,
--     update_in_insert = true,
--   }
-- )

vim.diagnostic.config({
  severity_sort = true,
  signs = true,
  update_in_insert = true,
  virtual_text = true,
  float = {
    severity_sort = true,
    source = "if_many",
  }
})

local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")
local log = require("null-ls.logger")

null_ls.register({
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { 'bzl', 'bazel' },
  -- null_ls.generator creates an async source
  -- that spawns the command with the given arguments and options
  generator = null_ls.generator({
    command = 'buildifier',
    args = {
      '-lint',
      'warn',
      '-mode',
      'check',
      '-format',
      'json',
      -- NOTE: "load" is already reported by starlark_rust
      '-warnings=+out-of-order-load,+unsorted-dict-items,-module-docstring,-load',
    },
    to_stdin = true,
    -- from_stderr = true,
    -- choose an output format (raw, json, or line)
    format = 'json',
    check_exit_code = function(code, stderr)
      local success = code <= 1
      print(success)

      if not success then
          -- can be noisy for things that run often (e.g. diagnostics), but can
          -- be useful for things that run on demand (e.g. formatting)
          print(stderr)
      end

      return success
    end,
    -- use helpers to parse the output from string matchers,
    -- or parse it manually with a function
    -- on_output = helpers.diagnostics.from_patterns({
    --   -- {
    --   --     pattern = [[:(%d+):(%d+) [%w-/]+ (.*)]],
    --   --     groups = { 'row', 'col', 'message' },
    --   -- },
    --   {
    --     pattern = [[:(%d+): (.*)]],
    --     groups = { 'row', 'message' },
    --     severity = vim.diagnostic.severity.WARN,
    --   },
    -- }),
    on_output = function (params)
      log:debug(params)
      if not params.output or not params.output.files then
        return {}
      end

      local parser = helpers.diagnostics.from_json({})
      local diagnostics = {}

      for _, file in ipairs(params.output.files) do
        if file.errors then
          for _, error in ipairs(file.errors) do
            table.insert(diagnostics, {
              line = error.start.line,
              column = error.start.column,
              endLine = error['end'].line,
              endColumn = error['end'].column,
              level = 'error',
              message = error.message,
              ruleId = error.category,
            })
          end
        end
        if file.warnings then
          for _, warning in ipairs(file.warnings) do
            table.insert(diagnostics, {
              line = warning.start.line,
              column = warning.start.column,
              endLine = warning['end'].line,
              endColumn = warning['end'].column,
              level = 'warning',
              message = warning.message,
              ruleId = warning.category,
            })
          end
        end
      end

      log:debug(diagnostics)
      return parser({ output = diagnostics })
    end
  }),
})

null_ls.setup({
  -- debug = true
})

