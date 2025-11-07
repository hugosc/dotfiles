-- Theme toggle between wal and e-ink
local M = {}

M.current_theme = "wal" -- Default theme is now wal
M.last_wal_mtime = 0

--- Toggle between wal and e-ink colorscheme
M.toggle_theme = function()
  if M.current_theme == "wal" then
    -- Switch to e-ink
    vim.o.background = "dark"
    vim.cmd.colorscheme("e-ink")
    M.current_theme = "e-ink"
    vim.notify("Switched to e-ink colorscheme", vim.log.levels.INFO)
  else
    -- Switch to wal
    vim.o.background = "dark"
    vim.cmd.colorscheme("wal")
    M.current_theme = "wal"
    vim.notify("Switched to wal colorscheme", vim.log.levels.INFO)
  end
end

--- Set up file watcher for hot-reloading wal colors
M.setup_wal_watcher = function()
  local wal_colors_path = vim.fn.expand("~/.cache/wal/colors-wal.vim")
  
  -- Create a timer that checks the file modification time
  local check_wal_colors = function()
    local stat = vim.loop.fs_stat(wal_colors_path)
    if stat and M.current_theme == "wal" then
      if stat.mtime.sec > M.last_wal_mtime then
        M.last_wal_mtime = stat.mtime.sec
        -- Reload the colorscheme silently
        pcall(function()
          vim.cmd.colorscheme("wal")
        end)
      end
    end
  end
  
  -- Get initial mtime
  local stat = vim.loop.fs_stat(wal_colors_path)
  if stat then
    M.last_wal_mtime = stat.mtime.sec
  end
  
  -- Check every 2 seconds
  vim.loop.new_timer():start(2000, 2000, vim.schedule_wrap(check_wal_colors))
end

return M
