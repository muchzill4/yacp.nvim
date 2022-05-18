# 🎨 telescope-yacp.nvim

An extension for [telescope](https://github.com/nvim-telescope/telescope.nvim) that allows you to run arbitrary commands via a command palette.

Useful for repetitive, but map unworthy actions you frequently perform. Palette can be easily extended in a per-project setup.

## Setup

### Load extension

```lua
require("telescope").load_extension "yacp"
```

### Populate global command palette

```lua
require("telescope").setup {
  extensions = {
    yacp = {
      palette = {
         { name = "echo in term", cmd = "term echo SUCCESS" },
         { name = "echo", cmd = "!echo SUCCESS" },
         { name = "help", cmd = "Telescope help_tags" },
         { name = "hi", cmd = function() print("HI!") end },
         ...
      }
    }
  }
}
```

## Usage

```vim
" show command palette
:Telescope yacp

" re-run last command executed via command palette
:Telescope yacp replay
```

### Extending command palette

This can be useful in a project specific setup. Instead of polluting your global command palette, you can use `exrc` or [nvim-projectconfig](https://github.com/windwp/nvim-projectconfig) to run `palette.extend()` when running vim in a specific directory.

```lua
local palette = require "yacp.palette"

palette.extend({
  { name = "build", cmd = "make build" },
  ...
})
```

## Notes

- Adding a palette entry with duplicate name, will overwrite the command, but retain the order.

## Similar plugins

- [telescope-command-palette.nvim](https://github.com/LinArcX/telescope-command-palette.nvim)
- [command_center.nvim](https://github.com/FeiyouG/command_center.nvim)
