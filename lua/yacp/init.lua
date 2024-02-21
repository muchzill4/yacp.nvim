local notify = require "yacp.notify"
local palette = require "yacp.palette"

local M = {}

local provider = nil

local providers = {
  fzf = "yacp.providers.fzf",
  telescope = "yacp.providers.telescope",
  native = "yacp.providers.native",
}

local function is_valid_provider(name)
  return providers[name] ~= nil
end

M.yacp = function(opts)
  if provider ~= nil then
    require(providers[provider]).yacp(opts)
  end
end

M.replay = function()
  require("yacp.exec").replay()
end

M.setup = function(opts)
  opts = opts or {}

  if opts.provider == nil then
    opts.provider = "native"
  end

  if not is_valid_provider(opts.provider) then
    notify.of_error(
      "Invalid provider: "
        .. opts.provider
        .. ". Must be one of: 'native', 'fzf', 'telescope'."
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
