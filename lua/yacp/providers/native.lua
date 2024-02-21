local M = {}

local notify = require "yacp.notify"
local exec = require "yacp.exec"
local palette = require "yacp.palette"

local function make_select_entries(p)
  local entries = {}
  for _, entry in ipairs(p) do
    table.insert(entries, entry.name)
  end
  return entries
end

local function find_command(p, name)
  for _, entry in ipairs(p) do
    if entry.name == name then
      return entry.cmd
    end
  end
  return nil
end

function M.yacp(opts)
  local p = palette.list()
  if vim.tbl_isempty(palette) then
    notify.of_error "Empty command palette"
    return
  end
  local entries = make_select_entries(p)

  local defaults = {
    prompt = "",
  }

  opts = vim.tbl_deep_extend("keep", opts or {}, defaults)

  vim.ui.select(entries, opts, function(choice)
    local cmd = find_command(p, choice)
    if cmd ~= nil then
      exec.exec(cmd)
    end
  end)
end

return M
