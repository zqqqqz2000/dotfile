return {
  "mg979/vim-visual-multi",
  branch = "master",
  enable = true,
  config = function()
    vim.keymap.set("n", "<leader>j", "<Plug>(VM-Add-Cursor-Down)")
    vim.keymap.set("n", "<leader>k", "<Plug>(VM-Add-Cursor-Up)")
    vim.keymap.set("n", "<C-n>", "<Plug>(VM-Find-Under)")
  end,
}
