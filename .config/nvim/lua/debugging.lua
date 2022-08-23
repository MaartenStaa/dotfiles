-- Debugging
require('dapui').setup({})
require('nvim-dap-virtual-text').setup({})
local dap = require('dap')

require('dap-vscode-js').setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = '/Users/maartens/.config/nvim/plugged/vscode-js-debug', -- Path to vscode-js-debug installation.
  adapters = { 'pwa-node' }, -- which adapters to register in nvim-dap
})
for _, language in ipairs({ 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' }) do
  local sourceMaps = language == 'typescript' or language == 'typescriptreact'
  dap.configurations[language] = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch file',
      program = '${file}',
      cwd = '${workspaceFolder}',
      sourceMaps = sourceMaps,
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach',
      processId = require 'dap.utils'.pick_process,
      cwd = '${workspaceFolder}',
      sourceMaps = sourceMaps,
    },
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Debug Jest Tests',
      -- trace = true, -- include debugger info
      runtimeExecutable = 'node',
      runtimeArgs = {
        './node_modules/jest/bin/jest.js',
        '--runInBand',
      },
      rootPath = '${workspaceFolder}',
      cwd = '${workspaceFolder}',
      sourceMaps = sourceMaps,
      console = 'integratedTerminal',
      internalConsoleOptions = 'neverOpen',
    }
  }
end

vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '⭕', texthl = '', linehl = '', numhl = '' })

vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dc', function() dap.continue() end)
vim.keymap.set('n', '<Leader>dso', function() dap.step_over({}) end)
vim.keymap.set('n', '<Leader>dsi', function() dap.step_into() end)
vim.keymap.set('n', '<Leader>r', function() dap.repl.open() end)
