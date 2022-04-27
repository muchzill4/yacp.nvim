local function feed_keys(keys)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(keys, true, false, true),
    "n",
    true
  )
end

return function(cmd)
  feed_keys(":" .. cmd .. "<CR>")
end
