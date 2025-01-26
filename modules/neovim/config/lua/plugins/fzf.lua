local function fzf_files()
  local fzf = require("fzf-lua")
  local base = vim.fn.fnamemodify(vim.fn.expand("%"), ":h:.:S")
  local fd = "fd --type f --strip-cwd-prefix --hidden"
  local icons = "~/.dotfiles/bin/file-web-devicon"
  local command
  if base == "." then
    command = fd .. " | " .. icons
  else
    command = vim.fn.printf('%s | proximity-sort "%s" | %s', fd, vim.fn.expand("%"), icons)
  end

  fzf.fzf_exec(command, {
    actions = fzf.config.defaults.actions.files,
    fzf_opts = { ["--nth"] = 2, ["--delimiter"] = fzf.utils.nbsp, ["--tiebreak"] = "index" },
    previewer = "builtin",
  })
end

return {
  "ibhagwan/fzf-lua",
  keys = {
    -- Disable default space-space
    { "<leader><space>", false },
    { "<C-p>", fzf_files, mode = { "n", "v", "o" }, desc = "Find files" },
    -- Overwrite <leader>sg and <leader>ff to search hidden files by default
    { "<leader>sg", LazyVim.pick("live_grep", { hidden = true }), desc = "Grep (Root Dir)" },
  },
}
