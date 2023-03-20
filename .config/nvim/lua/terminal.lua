-- local term_buf = nil
-- local term_win = nil

-- function TermToggle(width)
--   local cur_win = vim.api.nvim_get_current_win()
--   if term_win == cur_win then
--     vim.api.nvim_command("hide")
--     term_win = nil
--     return
--   else
--     -- vim.api.nvim_command("vertical rightbelow new")
--     -- vim.api.nvim_command("vertical resize " .. width)
--     if term_buf == nil then
--       local cmd = os.getenv("SHELL") or 'sh'
--       vim.api.nvim_call_function("termopen", {cmd, {detach=0}})
--       term_buf = vim.api.nvim_get_current_buf()
--       vim.api.nvim_command("hide")
--       -- vim.api.nvim_buf_set_option(term_buf, 'number', false)
--       -- vim.api.nvim_buf_set_option(term_buf, 'relativenumber', false)
--       -- vim.api.nvim_buf_set_option(term_buf, 'signcolumn', 'no')
--     -- else
--     --   vim.api.nvim_command("buffer " .. term_buf)
--     end
--     term_win = vim.api.nvim_open_win(term_buf, true, {
--       relative = 'win',
--       bufpos = { 1, 1 },
--       width = width,
--       height = 100
--     })
--     vim.api.nvim_command("startinsert")
--   end
-- end

-- vim.keymap.set("n", "<A-t>", function() TermToggle(120) end, {noremap=true})
-- vim.keymap.set("i", "<A-t>", "<Esc><Cmd>lua TermToggle(120)<CR>", {noremap=true})
-- vim.keymap.set("t", "<A-t>", "<C-\\><C-n><Cmd>lua TermToggle(120)<CR>", {noremap=true})

-- vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {noremap=true})
-- vim.keymap.set("t", ":q!", "<C-\\><C-n>:q!<CR>", {noremap=true})

