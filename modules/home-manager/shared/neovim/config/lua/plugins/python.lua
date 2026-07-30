return {
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup("uv")
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_format" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local servers = { "pyright", "basedpyright", "ruff", "ruff_lsp", "pyrefly" }
      local enabled = { ruff = true, pyrefly = true }
      for _, server in ipairs(servers) do
        opts.servers[server] = opts.servers[server] or {}
        opts.servers[server].enabled = enabled[server] or false
      end
    end,
  },
}
