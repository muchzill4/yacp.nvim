# 🎨 yacp.nvim

An extension for neovim that allows you to run arbitrary commands via a command palette.

Useful for repetitive, but map unworthy actions you frequently perform.

![yacp](../assets/yacp.png)

## Setup

### Install

```lua
use {
  "muchzill4/yacp.nvim",
  requires = {
    "nvim-telescope/telescope.nvim",
    -- or "ibhagwan/fzf-lua"
  },
}
```

### Configure

```lua
require("yacp").setup {
  provider = "telescope", -- or "fzf"
  palette = {
    { name = "echo in term", cmd = "term echo SUCCESS" },
    { name = "help", cmd = "Telescope help_tags" },
    { name = "hi", cmd = function() print("HI!") end },
    {
      name = "do stuff only in go files",
      cmd = "...",
      show = function()
        return vim.bo.filetype == "go"
      end
    },
  },
}
```

## Usage

```vim
:lua require("yacp").yacp()
```

Re-run last command executed via command palette:

```vim
:lua require("yacp").replay()
```

### Extending command palette

This can be useful in a project specific setup. Instead of polluting your global command palette via `setup()`, you can use `exrc` or [windwp/nvim-projectconfig](https://github.com/windwp/nvim-projectconfig) to run `palette.extend()` when running vim in a specific directory.

```lua
local palette = require "yacp.palette"

palette.extend({
  { name = "build", cmd = "make build" },
  ...
})
```

### Focus

Focus is an optional feature, which allows you to set a temporary palette entry named "focus run".

- "Focus run" becomes visible, once focus command is set
- You can set the focus command by using either:
  - "focus set" palette entry
  - `:lua require("yacp.focus").set()`

To use focus, you need to first enable it in your setup:

```lua
require("yacp").setup {
  ...
  enable_focus = true,
}
```

https://user-images.githubusercontent.com/454838/221367839-e9e403c3-b929-44fc-8273-5630f573193b.mp4

#### Workflow hint

1. Run a command you'd like to focus on using vim command line mode
2. Execute "focus set" entry from command palette
3. Paste the command you've run in step 1. using `":` vim register: `<C-r>:`

## Similar plugins

- [telescope-command-palette.nvim](https://github.com/LinArcX/telescope-command-palette.nvim)
- [command_center.nvim](https://github.com/FeiyouG/command_center.nvim)
