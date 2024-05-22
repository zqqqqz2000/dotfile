return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function()
    local events = require("neo-tree.events")
    return {
      auto_expand_width = true,
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["<space>"] = "none",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
              vim.print(string.format("copied path '%s'", path))
            end,
            desc = "Copy Path to Clipboard",
          },
          ["O"] = {
            function(state)
              local path = state.tree:get_node().path
              require("lazy.util").open(path, { system = true })
              vim.print(string.format("had open '%s' in system app", path))
            end,
            desc = "Open with System Application",
          },
        },
      },
      event_handlers = {
        {
          event = events.NEO_TREE_BUFFER_ENTER,
          handler = function()
            vim.opt_local.relativenumber = true
            vim.opt_local.number = true
          end,
        },
      },
    }
  end,
}
