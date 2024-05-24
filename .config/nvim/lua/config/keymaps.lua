-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

local set_telescope_filter = function()
  local telescope_config = require("telescope.config")
  local patterns = telescope_config.values.file_ignore_patterns
  local event = require("nui.utils.autocmd").event

  local Popup = require("nui.popup")
  local popup = Popup({
    enter = true,
    focusable = true,
    relative = "editor",
    border = {
      style = "rounded",
      text = {
        top = "Telescope File Ignore (Per line Per Regex)",
      },
    },
    position = "50%",
    size = {
      width = "50%",
      height = "30%",
    },
  })
  local regex_buffer = {}
  if patterns ~= nil then
    regex_buffer = patterns
  end

  vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, regex_buffer)

  popup:on(event.BufWinLeave, function()
    local lines = vim.api.nvim_buf_get_lines(popup.bufnr, 0, -1, false)
    local ignore_patterns = {}
    for _, v in pairs(lines) do
      if v ~= "" then
        table.insert(ignore_patterns, v)
      end
    end

    telescope_config.values.file_ignore_patterns = ignore_patterns
  end)

  popup:map("n", "q", function()
    popup:unmount()
  end, {})

  popup:mount()
end
map("n", "<leader>t", set_telescope_filter, { desc = "Set Telescope Filter" })
