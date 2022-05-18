local cmd = nil

local M = {}

function M.set(new_cmd)
  cmd = new_cmd
end

function M.input()
  M.set(vim.fn.input("Set focus cmd: "))
end

M.palette_entry = {
  name = "focus",
  expand = function()
    local entries = {}
    if cmd ~= nil then
      table.insert(entries, { name = "run", cmd = cmd })
    end
    table.insert(entries, { name = "set", cmd = M.input })
    return entries
  end,
}

return M
