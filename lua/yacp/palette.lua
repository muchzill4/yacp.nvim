local global_palette = {}

local function sort_by_name(palette)
  table.sort(palette, function(a, b)
    return a.name < b.name
  end)
end

local function find_index(palette, name)
  for i, entry in ipairs(palette) do
    if entry.name == name then
      return i
    end
  end
  return nil
end

-- Will overwrite existing entries with matching name
local function insert(palette, new_entry)
  local same_name_index = find_index(global_palette, new_entry.name)
  if same_name_index ~= nil then
    table.remove(palette, same_name_index)
  end
  table.insert(palette, new_entry)
end

local M = {}

function M.list()
  local expanded = {}
  for _, entry in ipairs(global_palette) do
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
    insert(global_palette, entry)
  end
  sort_by_name(global_palette)
end

return M
