if vim.g.started_by_firenvim == true then
  vim.o.cmdheight = 0
  vim.o.statusline = ""
  vim.o.laststatus = 0
  return {
    {
      "nvim-lualine/lualine.nvim",
      enabled = false,
    },
    {
      "folke/noice.nvim",
      enabled = false,
      opts = {
        notify = {
          enabled = false,
        },
      },
    },
    { "rcarriga/nvim-notify", enabled = false },
    { "glacambre/firenvim", build = ":call firenvim#install(0)" },
  }
else
  return { "glacambre/firenvim", build = ":call firenvim#install(0)" }
end
