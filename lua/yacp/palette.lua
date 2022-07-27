local palette = {}

local function sort_by_name(to_sort)
  table.sort(to_sort, function(a, b)
    return a.name < b.name
  end)
end

local function find_index(name)
  for i, entry in ipairs(palette) do
    if entry.name == name then
      return i
    end
  end
  return nil
end

-- Will overwrite existing entries with matching name
local function insert(new_entry)
  local same_name_index = find_index(new_entry.name)
  if same_name_index ~= nil then
    table.remove(palette, same_name_index)
  end
  table.insert(palette, new_entry)
  sort_by_name(palette)
end

local M = {}

function M.list()
  local expanded = {}
  for _, entry in ipairs(palette) do
    (function()
      if entry.show ~= nil and not entry.show() then
        return
      end
      -- This is so bad, I could use condition instead of the `expand` mallarky
      if entry.expand ~= nil then
        local sub_entries = entry.expand()
        sort_by_name(sub_entries)
        for _, sub_entry in ipairs(sub_entries) do
          sub_entry.name = entry.name .. " " .. sub_entry.name
          table.insert(expanded, sub_entry)
        end
      else
        table.insert(expanded, entry)
      end
    end)()
  end
  return expanded
end

function M.extend(palette_entries)
  for _, entry in ipairs(palette_entries) do
    insert(entry)
  end
end

return M
