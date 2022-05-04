local function feed_keys(keys)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(keys, true, false, true),
    "n",
    true
  )
end

local function run_cmd(cmd)
  feed_keys(":" .. cmd .. "<CR>")
end

return function(cmd)
  if type(cmd) == "function" then
    cmd()
  else
    run_cmd(cmd)
  end
end
