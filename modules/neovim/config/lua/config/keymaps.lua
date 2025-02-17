-- Remove some LazyVim keymaps
-- Don't use flash.nvim's f and t replacements
vim.keymap.del({ "n", "v" }, "f")
vim.keymap.del({ "n", "v" }, "F")
vim.keymap.del({ "n", "v" }, "t")
vim.keymap.del({ "n", "v" }, "T")
vim.keymap.del({ "n", "v" }, ";")
vim.keymap.del({ "n", "v" }, ",")

-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
vim.keymap.set("n", "<leader><space>", "<C-^>", { noremap = true, desc = "Switch between the last two files" })
vim.keymap.set("n", "H", "^", { noremap = true, desc = "Go to the start of the line" })
vim.keymap.set("n", "L", "$", { noremap = true, desc = "Go to the end of the line" })

-- Yank and Paste to system clipboard
vim.keymap.set({ "n", "v" }, "<Leader>y", '"+y', { noremap = true, desc = "yank to system clipboard" })
vim.keymap.set(
  { "n", "v" },
  "<Leader>yf",
  ':let @+ = expand("%")<cr>',
  { noremap = true, silent = true, desc = "yank file path to system clipboard" }
)
vim.keymap.set({ "n", "v" }, "<Leader>p", '"+p', { noremap = true, desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<Leader>P", '"+P', { noremap = true, desc = "Paste from system clipboard (before)" })

-- Move visual selection up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move visual selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move visual selection up" })

-- Join lines but keep cursor in the same place
vim.keymap.set("n", "J", "mzJ`z", { noremap = true, silent = true, desc = "Join lines" })

-- Keep cursor in the middle while paging up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true, desc = "Page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true, desc = "Page up" })

-- Go to test for this file
vim.keymap.set("n", "gt", function()
  local filename = vim.fn.expand("%")
  if not filename:find("[tj]sx?$") or filename:find("\\.test\\.") then
    return
  end

  local extension = vim.fn.expand("%:e")
  local basename = filename:sub(1, filename:len() - extension:len())

  -- test file with same extension
  local testfile = string.format("%stest.%s", basename, extension)
  if vim.fn.filereadable(testfile) ~= 0 then
    vim.cmd("e " .. testfile)
    return
  end

  -- js or tsx file with ts test
  local tstestfile = string.format("%stest.ts", basename)
  if extension == "js" or extension == "tsx" then
    if vim.fn.filereadable(tstestfile) ~= 0 then
      vim.cmd("e " .. tstestfile)
      return
    end
  end
  print("not found")
end, { noremap = true, silent = true, desc = "Jump to test file" })

if vim.g.neovide then
  vim.keymap.set("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
  vim.keymap.set("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.keymap.set("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.keymap.set("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

  local function guifontscale(n)
    if type(n) ~= "number" then
      return
    end

    local gfa = {}
    for c in vim.gsplit(vim.o.guifont, ":") do
      table.insert(gfa, c)
    end
    local buildnewgf = ""
    local fweight = ""
    for _, v in ipairs(gfa) do
      if v:find("h", 1, true) == 1 then
        fweight = ""
        for w in vim.gsplit(v, "h") do
          local wn = tonumber(w)
          if wn ~= nil then
            wn = wn + n
            fweight = fweight .. tostring(wn)
          end
        end

        buildnewgf = buildnewgf .. "h" .. fweight .. ":"
      else
        v = string.gsub(v, " ", "_")
        buildnewgf = buildnewgf .. v .. ":"
      end
    end

    local setcmd = "set guifont=" .. buildnewgf
    vim.cmd(setcmd)
  end

  vim.keymap.set("n", "<D-=>", function()
    guifontscale(1)
  end, { noremap = true, desc = "Increase font size" })
  vim.keymap.set("n", "<D-->", function()
    guifontscale(-1)
  end, { noremap = true, desc = "Decrease font size" })
end
