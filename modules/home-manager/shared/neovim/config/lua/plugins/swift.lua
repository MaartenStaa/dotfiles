return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sourcekit = {
          ["sourcekit-lsp"] = {
            inlayHints = {
              enabled = true,
            },
          },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        swift = { "swiftlint" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        swift = { "swiftformat", "swiftlint" },
      },
    },
  },
}
