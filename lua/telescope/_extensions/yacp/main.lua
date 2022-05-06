local M = {}

local action_state = require "telescope.actions.state"
local actions = require "telescope.actions"
local conf = require("telescope.config").values
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local utils = require "telescope.utils"

local palette = require "yacp.palette"
local exec = require "telescope._extensions.yacp.exec"

local last_selection = nil

function M.setup(config)
  if config.palette then
    palette._telescope_init(config.palette)
  end
end

function M.yacp(opts)
  opts = opts or {}
  local p = palette.list()

  if vim.tbl_isempty(p) then
    utils.notify("extensions.yacp", {
      msg = "Empty command palette",
      level = "INFO",
    })
    return
  end

  local function finder()
    return finders.new_table {
      results = p,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.name,
          ordinal = entry.name,
        }
      end,
    }
  end

  pickers.new(opts, {
    prompt_title = "Command palette",
    finder = finder(),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        if selection == nil then
          return
        end
        actions.close(prompt_bufnr)
        last_selection = selection.value
        exec(selection.value.cmd)
      end)
      return true
    end,
  }):find()
end

function M.replay()
  if last_selection ~= nil then
    exec(last_selection.cmd)
  else
    utils.notify("extensions.yacp", {
      msg = "No last command palette command to replay",
      level = "INFO",
    })
  end
end

return M
