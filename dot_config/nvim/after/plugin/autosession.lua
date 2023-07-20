require('lualine').setup {
  options = {
    theme = 'tokyonight',
    auto_save_enabled = true,
    auto_restore_enabled = true,
  },
}
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
