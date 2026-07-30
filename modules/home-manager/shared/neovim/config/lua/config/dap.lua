local dap = require("dap")

dap.adapters.lldb = {
  type = "executable",
  -- type = "server",
  -- port = "${port}",
  -- executable = {
  command = "/Users/maartens/.vscode/extensions/vadimcn.vscode-lldb-1.12.1/adapter/codelldb", -- adjust as needed, must be absolute path
  --   arguments = { "--port", "${port}" },
  -- },
  name = "lldb",
}

dap.configurations.lua = {
  {
    name = "Run Lua file",
    type = "lldb",
    request = "launch",
    -- program = "cargo",

    program = function()
      return vim.fn.getcwd() .. "/target/debug/lua_interpreter"
    end,
    cwd = "${workspaceFolder}",
    args = {
      -- "run",
      -- "--",
      "${file}",
    },

    stopOnEntry = false,
  },
}
