-- Set up LSP installer, manually adding the Relay LS.
-- require('mason').setup()
-- require('mason-lspconfig').setup({
--   automatic_installation = true,
-- })

-- local lsp_installer = require('nvim-lsp-installer')
-- local npm = require('nvim-lsp-installer.core.managers.npm')
-- lsp_installer.setup({
--   automatic_installation = true
-- })
-- local relay_install_dir = require('nvim-lsp-installer.core.path').concat({
--   require('nvim-lsp-installer.settings').current.install_root_dir,
--   'relay',
-- })
-- lsp_installer.register(require('nvim-lsp-installer.server').Server:new {
--   name = 'relay',
--   root_dir = relay_install_dir,
--   languages = { 'graphql', 'typescriptreact' },
--   homepage = 'https://github.com/facebook/relay',
--   installer = npm.packages { 'relay-compiler' },
--   default_options = {
--     cmd_env = npm.env(relay_install_dir),
--   },
-- })

-- LSP configuration
local lspconfig = require('lspconfig')
---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
  -- Mappings.
  local opts = { buffer = bufnr, noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('error', opts, { desc = 'Show hover information' }))
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend('error', opts, { desc = 'Signature help' }))
  vim.keymap.set({'n', 'v'}, '<Leader>rn', vim.lsp.buf.rename, vim.tbl_extend('error', opts, { desc = 'Rename symbol' }))
  vim.keymap.set({'n', 'v'}, '<Leader>a', vim.lsp.buf.code_action, vim.tbl_extend('error', opts, { desc = 'Show code actions' }))
  vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, vim.tbl_extend('error', opts, { desc = 'Detailed error information' }))
  vim.keymap.set({'n', 'v'}, '[c', vim.diagnostic.goto_prev, vim.tbl_extend('error', opts, { desc = 'Jump to next error' }))
  vim.keymap.set({'n', 'v'}, ']c', vim.diagnostic.goto_next, vim.tbl_extend('error', opts, { desc = 'Jump to previous error' }))
  -- vim.keymap.set({'n', 'v'}, '<Leader>f', function() vim.lsp.buf.format({ async = true }) end, vim.tbl_extend('error', opts, { desc = 'Format buffer' }))
  vim.keymap.set('n', '<Leader>i', function()
    if vim.lsp.inlay_hint.is_enabled() then
      vim.lsp.inlay_hint.enable(false)
    else
      vim.lsp.inlay_hint.enable(true)
    end
  end, vim.tbl_extend('error', opts, { desc = 'Toggle inlay hints' }))

  vim.keymap.set({'n', 'v'}, '<Leader>q', vim.diagnostic.setloclist, vim.tbl_extend('error', opts, { desc = 'Add buffer diagnostics to loclist' }))
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
if not lsp_configs.oxlint then
  lsp_configs.oxlint = {
    default_config = {
      cmd = { 'oxc_vscode.sh' },
      filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
      root_dir = function(fname)
        local util = require('lspconfig.util')
        return util.root_pattern('package.json', '.git')(fname)
      end,
      settings = {
        run = 'onType',
        enable = true,
        trace = {
          server = 'off',
        },
      }
    },
  }
end

local servers = {
  bashls = {},
  clangd = {
    cmd = { 'clangd', '--offset-encoding=utf-16'}
  },
  cssls = {},
  cssmodules_ls = {},
  dockerls = {},
  eslint = {
    filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx',
      'vue', 'svelte', 'astro' },
    root_dir = function(fname)
      local util = require('lspconfig.util')
      return util.root_pattern('relay.config.json')(fname)
          or util.root_pattern('package.json', '.git')(fname)
    end,
    settings = {
      eslint = {
        packageManager = 'pnpm',
      }
    }
  },
  gopls = {
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true
        },
      },
    },
  },
  intelephense = {},
  jdtls = {},
  jedi_language_server = {},
  jsonls = {
    capabilities = {
      textDocument = {
        completion = {
          completionItem = { snippetSupport = true },
        },
      },
    },
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = true,
      }
    }
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        hint = {
          enable = true,
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
  nil_ls = {
    settings = {
      ['nil'] = {
        formatting = {
          command = { "nixfmt" },
        },
        nix = {
          flake = {
            autoArchive = true,
          },
        },
      },
    },
  },
  oxlint = {},
  -- relay = {},
  starlark_rust = {
    cmd = { '/Users/maartens/repos/github/facebookexperimental/starlark-rust/target/debug/starlark', '--lsp', '--bazel', '--eager'},
    filetypes = { "star", "bzl", "BUILD.bazel", "MODULE.bazel", "WORKSPACE.bazel", "WORKSPACE.bzlmod", "BUILD", "MODULE", "WORKSPACE" },
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
  sourcekit = {
    capabilities = {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    },
  },
  taplo = {},
  ts_ls = {
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = false,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        }
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = false,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        }
      }
    },
  },
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
          '!ReWrite mapping',
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

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
--   vim.lsp.handlers.hover, {
--     -- Use a sharp border with `FloatBorder` highlights
--     border = 'rounded',
--     -- add the title in hover float window
--     -- title = "hover"
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
-- local log = require("null-ls.logger")

if vim.fn.has 'nvim-0.5.1' == 1 then
  require('vim.lsp.log').set_format_func(vim.inspect)
end

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

      return parser({ output = diagnostics })
    end
  }),
})

null_ls.setup({
  -- debug = true
})

