local M = {}

function M.of_error(msg)
  vim.notify(string.format("yacp: %s", msg), vim.log.levels["ERROR"])
end

return M
