local M = {}

local notify = require "yacp.notify"
local exec = require "yacp.exec"
local palette = require "yacp.palette"

local function make_fzf_entries(p)
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
  local entries = make_fzf_entries(p)

  local defaults = {
    winopts = {
      height = 0.65,
      width = 0.50,
    },
    actions = {
      ["default"] = function(selected)
        if selected then
          local cmd = find_command(p, selected[1])
          if cmd ~= nil then
            exec.exec(cmd)
          end
        end
      end,
    },
  }
  opts = vim.tbl_deep_extend("keep", opts or {}, defaults)
  require("fzf-lua").fzf_exec(entries, opts)
end

function M.replay()
  exec.replay()
end

return M
