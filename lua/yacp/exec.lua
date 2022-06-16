local notify = require "yacp.notify"

local last_cmd = nil

local function feed_keys(keys)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(keys, true, false, true),
    "n",
    true
  )
end

local function run_vim_command(cmd)
  feed_keys(":" .. cmd .. "<CR>")
end

local M = {}

function M.exec(cmd)
  if type(cmd) == "function" then
    cmd()
  else
    run_vim_command(cmd)
  end
end

function M.replay()
  if last_cmd ~= nil then
    M.exec(last_cmd)
  else
    notify.of_error "No last command to replay"
  end
end

return M
