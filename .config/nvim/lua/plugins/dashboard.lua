return {
  "snacks.nvim",
  opts = {
    dashboard = {
      sections = {
        {
          section = "terminal",
          cmd = "pokemon-colorscripts -r --no-title; sleep .1",
          random = 10,
          indent = 15,
          height = 20,
        },
        {
          pane = 2,
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
    },
  },
}
