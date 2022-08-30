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
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[c', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']c', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)

  buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
end

local function merge(a, b)
  for k, v in pairs(b) do
    a[k] = v
  end

  return a
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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
  eslint = {},
  intelephense = {},
  marksman = {},
  relay = {},
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          -- Do not send telemetry data containing a randomized but unique identifier
          enable = false,
        },
      },
    },
  },
  rust_analyzer = {},
  tsserver = {},
  vimls = {},
  yamlls = {}
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

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
