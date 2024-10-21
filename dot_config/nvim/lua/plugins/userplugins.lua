-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "catppuccin/nvim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },

}
