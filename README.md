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

### Focus

Focus is an optional feature, which allows you to set a temporary palette entry named "focus run".
"Focus run" becomes visible, once focus command is set. You can set it by using either "focus set" palette entry or `:lua require("yacp.focus").set()`.

To use focussing, you need to add its entry to your command palette:

```lua
palette.extend({
  require("yacp.focus").palette_entry,
  ...
})
```

_Workflow hint:_

1. Run a command you'd like to focus on using vim command line mode
2. Execute "focus set" entry from command palette
3. Paste the command you've run in step 1. using `":` vim register: `<C-r>:`

## Notes

- Adding a palette entry with duplicate name, will overwrite the command, but retain the order.

## Similar plugins

- [telescope-command-palette.nvim](https://github.com/LinArcX/telescope-command-palette.nvim)
- [command_center.nvim](https://github.com/FeiyouG/command_center.nvim)
