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
}
