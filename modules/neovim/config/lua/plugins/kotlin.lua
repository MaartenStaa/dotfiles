local parser = nil
local function parse_detekt_output(...)
  if parser == nil then
    parser = require("lint.parser").from_errorformat(
      [[%f:%l:%c: %m]],
      {
        source = "detekt",
        severity = vim.diagnostic.severity.ERROR,
      }
    )
  end

  return parser(...)
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        kotlin_language_server = {},
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        kotlin = { "detekt" },
      },
      linters = {
        detekt = {
          cmd = "detekt",
          args = { "--input" },
          stdin = false,
          stream = "stdout",
          ignore_exitcode = true,
          parser = parse_detekt_output,
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        kotlin = { "ktfmt" },
      },
      formatters = {
        ktfmt = {
          prepend_args = { "--google-style" },
        },
      },
    },
  },
}
