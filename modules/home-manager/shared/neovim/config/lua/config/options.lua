-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
vim.g.snacks_animate = false
vim.opt.clipboard = ""
vim.opt.smoothscroll = false
vim.opt.colorcolumn = "80,120,+1"

if vim.g.neovide then
  vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h14"

  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_trail_size = 0.4
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"
  vim.g.neovide_scroll_animation_far_lines = 99999
  vim.g.neovide_scroll_animation_length = 0.2

  vim.opt.shell = "fish"
end
