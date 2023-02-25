local notify = require "yacp.notify"
local palette = require "yacp.palette"

local M = {}

local provider = nil

local providers = {
  fzf = "yacp.providers.fzf",
  telescope = "yacp.providers.telescope",
}

local function is_valid_provider(name)
  return providers[name] ~= nil
end

M.yacp = function()
  if provider ~= nil then
    require(providers[provider]).yacp()
  end
end

M.replay = function()
  require("yacp.exec").replay()
end

M.setup = function(opts)
  opts = opts or {}

  if opts.provider == nil then
    notify.of_error "Missing provider setting"
    return
  elseif not is_valid_provider(opts.provider) then
    notify.of_error(
      "Invalid provider: "
        .. opts.provider
        .. ". Must be one of: 'fzf', 'telescope'."
    )
    return
  end
  provider = opts.provider

  if opts.palette ~= nil then
    palette.extend(opts.palette)
  end

  if opts.enable_focus then
    palette.extend {
      require("yacp.focus").palette_entry,
    }
  end
end

return M
