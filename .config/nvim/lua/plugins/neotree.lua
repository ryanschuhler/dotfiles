-- ABOUTME: Configures the NeoTree plugin.
-- ABOUTME: Enables showing hidden files by default.

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- al for file icons
    "MunifTanjim/nui.nvim", -- UI components
  },
  opts = {
    filesystem = {
      hijack_netrw = true,
      hide_hidden = false, -- Set to true to hide hidden files, false to show them
      filtered_items = {
        hide_dotfiles = false, -- Set to false to show dotfiles
        hide_git_untracked = false,
        hide_by_name = {
          "node_modules",
        },
        always_show = { -- Add the name of files or directories you want to always show.
          ".gitignore",
        },
        never_show = { -- Add the name of files or directories you want to never show.
          -- ".DS_Store",
          --"thumbs.db",
        },
      },
    },
  },
}