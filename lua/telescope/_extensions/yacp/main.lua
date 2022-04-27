local M = {}

local action_state = require "telescope.actions.state"
local actions = require "telescope.actions"
local conf = require("telescope.config").values
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local utils = require "telescope.utils"

local palette = require "telescope._extensions.yacp.palette"
local run_cmd = require "telescope._extensions.yacp.run_cmd"

local last_selection = nil

function M.setup(config)
  if config.palette then
    palette.telescope_init(config.palette)
  end
end

function M.yacp(opts)
  opts = opts or {}

  if vim.tbl_isempty(palette.palette) then
    utils.notify("extensions.yacp", {
      msg = "Empty command palette",
      level = "INFO",
    })
    return
  end

  local function finder()
    return finders.new_table {
      results = palette.palette,
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
        run_cmd(selection.value.cmd)
      end)
      return true
    end,
  }):find()
end

function M.replay()
  if last_selection ~= nil then
    run_cmd(last_selection.cmd)
  else
    utils.notify("extensions.yacp", {
      msg = "No last command palette command to replay",
      level = "INFO",
    })
  end
end

return M
