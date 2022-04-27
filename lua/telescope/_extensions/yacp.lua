local has_telescope, telescope = pcall(require, "telescope")

if not has_telescope then
  error "This plugin requires nvim-telescope/telescope.nvim"
end

local main = require "telescope._extensions.yacp.main"
local palette = require "telescope._extensions.yacp.palette"

return telescope.register_extension {
  setup = main.setup,
  exports = { yacp = main.yacp, replay = main.replay, palette = palette },
}
