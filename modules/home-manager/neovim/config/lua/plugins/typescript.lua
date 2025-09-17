vim.g.markdown_fenced_languages = {
  "ts=typescript",
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = { enabled = false },
        denols = {
          cmd_env = {
            DENO_UNSTABLE_SLOPPY_IMPORTS = 1,
            DENO_UNSTABLE_BARE_NODE_BUILTINS = 1,
            DENO_UNSTABLE_DETECT_CJS = 1,
            DENO_UNSTABLE_BYONM = 1,
          },
          deno = {
            enable = true,
            suggest = {
              completeFunctionCalls = true,
              names = true,
              paths = true,
              autoImports = true,
            },
            lint = {
              rules = {
                exclude = { "no-sloppy-imports" },
              },
            },
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
      },
    },
  },
}
