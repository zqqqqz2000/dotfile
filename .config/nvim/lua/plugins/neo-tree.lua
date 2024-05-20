return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function()
    local events = require("neo-tree.events")
    return {
      auto_expand_width = true,
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
