vim.g.firenvim_config = {
  globalSettings = { alt = "all" },
  localSettings = {
    [".*iwiki.*"] = {
      priority = 1,
      takeover = "never",
    },
  },
}

if vim.g.started_by_firenvim == true then
  vim.o.cmdheight = 0
  vim.o.statusline = ""
  vim.o.laststatus = 0

  vim.api.nvim_set_keymap("n", "<Esc><Esc>", "<Cmd>wq<CR><Cmd>call firenvim#focus_page()<CR>", {})

  return {
    { "glacambre/firenvim", build = ":call firenvim#install(0)" },
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
  }
else
  return { "glacambre/firenvim", build = ":call firenvim#install(0)" }
end
