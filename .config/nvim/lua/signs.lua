-- Configure the LSP diagnostic icons
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

-- Signs for git gutter
signs = {
  { type = 'Added', icon = '｜', hl = 'GitGutterAdd' },
  { type = 'Modified', icon = '｜', hl = 'GitGutterChange' },
  { type = 'Removed', icon = '＿', hl = 'GitGutterDelete' },
}
for _, sign in ipairs(signs) do
  local sign_name = 'GitGutterLine' .. sign.type
  local hl = sign.hl
  vim.fn.sign_define(sign_name, { text = sign.icon, texthl = hl, numhl = '' })
end
