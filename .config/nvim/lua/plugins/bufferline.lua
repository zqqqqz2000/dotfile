local bufferline = require("bufferline")

return {
  "akinsho/bufferline.nvim",
  keys = {
    {
      "<leader>bt",
      "<Cmd>BufferLineGroupToggle _Dependencies<CR><Cmd>BufferLineGroupToggle _Tests<CR>",
      desc = "Toggle Pin",
    },
  },
  opts = {
    ---@type bufferline.Options
    options = {
      groups = {
        options = {
          toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
        },
        items = {
          {
            name = " Tests",
            highlight = { sp = "#009900" }, -- Optional
            priority = 1, -- determines where it will appear relative to other groups (Optional)
            matcher = function(buf) -- Mandatory
              if buf.path == nil then
                return false
              end
              return buf.path:match("test.go") or buf.path:match("test/%.*")
            end,
            auto_close = true,
          },
          {
            name = " Dependencies", -- Mandatory
            highlight = { sp = "grey" }, -- Optional
            priority = 2, -- determines where it will appear relative to other groups (Optional)
            -- Dependecnies icon
            matcher = function(buf) -- Mandatory
              if buf.path == nil then
                return false
              end
              return buf.path:match("node_modules") or buf.path:match("vendor") or buf.path:match("venv")
            end,
            auto_close = true,
          },
        },
      },
    },
  },
}
