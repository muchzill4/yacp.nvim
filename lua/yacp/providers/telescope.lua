local M = {}

local action_state = require "telescope.actions.state"
local actions = require "telescope.actions"
local conf = require("telescope.config").values
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"

local exec = require "yacp.exec"
local notify = require "yacp.notify"
local palette = require "yacp.palette"

function M.setup(config)
  if config.palette then
    palette.extend(config.palette)
  end
end

function M.yacp(opts)
  opts = opts or {}
  local p = palette.list()

  if vim.tbl_isempty(p) then
    notify.of_error "Empty command palette"
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

  pickers
    .new(opts, {
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
          exec.exec(selection.value.cmd)
        end)
        return true
      end,
    })
    :find()
end

return M
