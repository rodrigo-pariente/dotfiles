return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
      default_file_explorer = true,
  },
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  lazy = false,
}
