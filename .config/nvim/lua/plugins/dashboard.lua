return {
  {
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
  },
  {
    "folke/snacks.nvim",
    optional = true,
    opts = function(_, opts)
      -- remove key = "s" from opts.dashboard.preset.keys
      -- aka. remove origin "Restore Session"
      opts.dashboard.preset.keys = vim.tbl_filter(function(k)
        return k.key ~= "s"
      end, opts.dashboard.preset.keys)

      table.insert(opts.dashboard.preset.keys, 1, {
        action = "<leader>qS",
        desc = "Sessions",
        icon = "➤ ",
        key = "s",
      })
    end,
  },
}
