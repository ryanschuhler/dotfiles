-- ABOUTME: Configuration for diffview.nvim
-- ABOUTME: Manages Git diffs within Neovim.

return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    -- Your Diffview configuration options can go here
    -- For example:
    -- keymaps = {
    --   'nvo',          -- Open Diffview
    --   'nvc',          -- Close Diffview
    --   'nvd',          -- Diff base
    --   'nvs',          -- Diff common ancestor
    --   'nvh',          -- Diff HEAD
    --   'nvm',          -- Diff merge base
    --   'nvy',          -- Diff yanked
    -- }
  }
}