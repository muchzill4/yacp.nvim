local M = {}

local palette = {}

local function shallowcopy(orig)
  local copy = {}
  for orig_key, orig_value in pairs(orig) do
    copy[orig_key] = orig_value
  end
  return copy
end

local function find_index(name)
  for i, entry in ipairs(palette) do
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
    table.remove(palette, same_name_index)
    table.insert(palette, same_name_index, new_entry)
  else
    table.insert(palette, new_entry)
  end
end

function M.prepend(palette_entries)
  local old_palette = shallowcopy(palette)
  palette = {}
  M.extend(palette_entries)
  M.extend(old_palette)
end

function M.list()
  return palette
end

function M.extend(palette_entries)
  for _, entry in ipairs(palette_entries) do
    insert(entry)
  end
end

return M
