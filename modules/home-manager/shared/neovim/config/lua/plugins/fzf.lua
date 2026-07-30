local watcher
local debounce_timer
local cooldown_timer
local updating = false
local cooldown_active = false
local pending = false
local tmp = ""

local function notif(msg, level)
  if level == nil then
    level = vim.log.levels.INFO
  end

  vim.schedule(function()
    if level == vim.log.levels.ERROR then
      vim.notify(msg, level)
    end
  end)
end

vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
  callback = function()
    local dir = vim.uv.cwd()
    if not dir then
      return
    end

    tmp = vim.uv.os_tmpdir() .. "/" .. vim.fn.sha256(dir)

    local function stop_close(x)
      if not x then
        return
      end

      pcall(function()
        x:stop()
      end)
      pcall(function()
        x:close()
      end)
    end

    stop_close(watcher)
    watcher = nil
    stop_close(debounce_timer)
    debounce_timer = nil
    stop_close(cooldown_timer)
    cooldown_timer = nil

    updating, cooldown_active, pending = false, false, false

    local burst_ms = 1000 -- 1 second
    local cooldown_ms = 15000 -- 15 seconds

    watcher = vim.uv.new_fs_event()
    debounce_timer = vim.uv.new_timer()
    cooldown_timer = vim.uv.new_timer()

    local function write_filelist(output)
      local fd, err, err_name = assert(vim.uv.fs_open(tmp, "w", tonumber("644", 8)))
      if not fd then
        notif("failed to open " .. tmp .. ": " .. err .. " (" .. err_name .. ")", vim.log.levels.ERROR)
        return
      end
      vim.uv.fs_write(fd, output)
      vim.uv.fs_close(fd)
    end

    local update_cached_files
    local function start_cooldown()
      if cooldown_active or cooldown_timer == nil or debounce_timer == nil then
        return
      end
      cooldown_active = true
      cooldown_timer:stop()
      cooldown_timer:start(cooldown_ms, 0, function()
        cooldown_active = false
        if pending then
          -- run one more after cooldown, with burst coalescing
          pending = false
          debounce_timer:stop()
          debounce_timer:start(burst_ms, 0, function()
            vim.schedule(function()
              vim.api.nvim_exec2("doautocmd User CachedFilesPreUpdate", {})
            end)
            -- call the updater
            vim.schedule(function()
              update_cached_files()
            end)
          end)
        end
      end)
    end

    update_cached_files = function()
      if updating then
        pending = true
        return
      end

      updating = true
      pending = false

      local stdout = vim.uv.new_pipe(false)

      assert(stdout)

      local handle, spawn_err
      ---@diagnostic disable-next-line: missing-fields
      handle, spawn_err = vim.uv.spawn("fd", {
        args = { "--type", "f", "--strip-cwd-prefix", "--hidden" },
        cwd = dir,
        stdio = { nil, stdout, nil },
      }, function()
        if handle and not handle:is_closing() then
          vim.uv.close(handle)
        end
      end)

      if not handle then
        notif("error spawning fd: " .. tostring(spawn_err), vim.log.levels.ERROR)
        updating = false
        return
      end

      local output = ""
      vim.uv.read_start(stdout, function(err, data)
        if err then
          -- stop reading and close handle on error
          pcall(function()
            vim.uv.read_stop(stdout)
          end)
          pcall(function()
            stdout:close()
          end)
          notif("fd read error: " .. tostring(err), vim.log.levels.ERROR)
        end

        if data then
          output = output .. data
          return
        end

        -- EOF
        pcall(function()
          vim.uv.read_stop(stdout)
        end)
        pcall(function()
          stdout:close()
        end)

        write_filelist(output)

        updating = false
        start_cooldown()
      end)
    end

    -- do it right away now
    update_cached_files()

    if not watcher then
      return
    end

    watcher:start(dir, {
      recursive = true,
    }, function(err, filename)
      if err then
        notif("fs_event error: " .. err, vim.log.levels.ERROR)
        return
      end

      if filename:sub(-1) == "~" then
        -- vim temp file
        return
      end
      for _, value in pairs({ ".git/", ".ruff-cache/", "target/" }) do
        if filename:find(value) ~= nil then
          return
        end
      end

      if updating then
        pending = true
        return
      end

      if cooldown_active then
        if not pending then
        end
        pending = true
        return
      end

      pending = false
      if debounce_timer and not debounce_timer:is_closing() then
        debounce_timer:stop()
        debounce_timer:start(burst_ms, 0, function()
          -- call the updater
          vim.schedule(function()
            update_cached_files()
          end)
        end)
      end
    end)
  end,
})

vim.api.nvim_create_autocmd("DirChangedPre", {
  callback = function()
    if debounce_timer then
      debounce_timer:stop()
      debounce_timer:close()
      debounce_timer = nil
    end

    if cooldown_timer then
      cooldown_timer:stop()
      cooldown_timer:close()
      cooldown_timer = nil
    end

    if watcher then
      watcher:stop()
      watcher:close()
      watcher = nil
    end
  end,
})

local function fzf_files()
  local fzf = require("fzf-lua")
  local base = vim.fn.fnamemodify(vim.fn.expand("%"), ":h:.:S")
  local fd = "fd --type f --strip-cwd-prefix --hidden"
  local icons = "~/.dotfiles/bin/file-web-devicon"
  local cat = "cat " .. tmp
  local src = fd
  local command
  if base == "." then
    command = src .. " | " .. icons
  else
    command = vim.fn.printf("%s | %s", src, icons)
  end

  fzf.fzf_exec(command, {
    actions = fzf.config.defaults.actions.files,
    fzf_opts = {
      ["--nth"] = 2,
      ["--delimiter"] = fzf.utils.nbsp,
      ["--scheme"] = "path",
    },
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
