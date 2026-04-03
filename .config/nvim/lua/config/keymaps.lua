-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function toggle_snack(id, cmd)
  local snacks = require("snacks")
  for _, term in pairs(snacks.config.terminals) do
    if term.win and term.id ~= id then
      snacks.terminal.close(term.id)
    end
  end

  snacks.terminal.toggle(cmd, {
    id = id,
    win = {
      style = "float",
      width = 0.9,
      height = 0.9,
      border = "rounded",
    },
  })
end

vim.keymap.set({ "n", "t" }, "<C-/>", function()
  toggle_snack("terminal")
end, { desc = "Toggle Terminal" })
vim.keymap.set({ "n", "t" }, "<C-a>", function()
  toggle_snack("gemini", "gemini")
end, { desc = "Toggle Gemini" })
vim.keymap.set({ "n", "t" }, "<C-g>", function()
  toggle_snack("lazygit", "lazygit")
end, { desc = "Toggle LazyGit" })
vim.keymap.set({ "n", "t" }, "<C-k>", function()
  toggle_snack("k9s", "k9s")
end, { desc = "Toggle K9s" })
vim.keymap.set({ "n", "t" }, "<C-w>", "<cmd>close<CR>", { desc = "Close current window" })
vim.keymap.set({ "n", "t" }, "<C-q>", "<cmd>bdelete!<CR>", { desc = "Destroy current buffer" })
