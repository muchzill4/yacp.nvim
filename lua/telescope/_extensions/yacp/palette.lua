local M = {}

M.palette = {}

M._telescope_setup_run = false

local function shallowcopy(orig)
  local copy = {}
  for orig_key, orig_value in pairs(orig) do
    copy[orig_key] = orig_value
  end
  return copy
end

local function find_index(name)
  for i, entry in ipairs(M.palette) do
    if entry.name == name then
      return i
    end
  end
  return nil
end

-- Will overwrite existing entries, but retain their index.
local function insert(new_entry)
  local same_name_index = find_index(new_entry.name)
  if same_name_index ~= nil then
    table.remove(M.palette, same_name_index)
    table.insert(M.palette, same_name_index, new_entry)
  else
    table.insert(M.palette, new_entry)
  end
end

-- It's possible telescope will run plugin setup after .extend() was called,
-- this really is a prepend followed by re-inserting existing entries.
function M.telescope_init(palette)
  local old = shallowcopy(M.palette)
  M.palette = {}
  M.extend(palette)
  M.extend(old)
end

function M.extend(palette)
  for _, entry in ipairs(palette) do
    insert(entry)
  end
end

return M
