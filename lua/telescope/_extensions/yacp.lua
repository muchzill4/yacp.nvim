local has_telescope, telescope = pcall(require, "telescope")

if not has_telescope then
  error "This plugin requires nvim-telescope/telescope.nvim"
end

local provider = require "yacp.providers.telescope"
local exec = require "yacp.exec"

return telescope.register_extension {
  setup = provider.setup,
  exports = { yacp = provider.yacp, replay = exec.replay },
}
