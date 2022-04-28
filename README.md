# 🎨 telescope-yacp.nvim

An extension for [telescope](https://github.com/nvim-telescope/telescope.nvim) that allows you to run arbitrary commands via a command palette.

Useful for repetitive, but map unworthy actions you frequently perform. Palette can be easily extended in a per-project setup.

## Setup

### Load extension

```lua
require("telescope").load_extension "yacp"
```

### Create common command palette

```lua
require('telescope').setup {
  extensions = {
    yacp = {
      palette = {
         { name = "echo in term", cmd = "term echo SUCCESS" },
         { name = "echo", cmd = "!echo SUCCESS" },
         { name = "help", cmd = "Telescope help_tags" },
         ...
      }
  }
}
```

### Extend per project

Can be done using `exrc` or [nvim-projectconfig](https://github.com/windwp/nvim-projectconfig).

```lua
local palette = require('telescope').extensions.yacp.palette

palette.extend({
  { name = "build", cmd = "make build" },
  ...
})
```

### Map keys

```lua
-- bring up command palette
vim.api.nvim_set_keymap(
  "n",
  "<leader>p",
  "<Cmd>Telescope yacp<CR>",
  {noremap = true, silent = true}
)

-- replay last command
vim.api.nvim_set_keymap(
  "n",
  "<Leader>P",
  "<Cmd>lua require('telescope').extensions.yacp.replay()<CR>",
  {noremap = true, silent = true}
)
```

## Notes

- Adding a palette entry with duplicate name, will overwrite the command, but retain the order.

## Similar plugins

- [telescope-command-palette.nvim](https://github.com/LinArcX/telescope-command-palette.nvim)
- [command_center.nvim](https://github.com/FeiyouG/command_center.nvim)
