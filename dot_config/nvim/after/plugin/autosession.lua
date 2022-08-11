require('lualine').setup{
  options = {
    theme = 'tokyonight',
    auto_save_enabled = true,
    auto_restore_enabled = true,
  },
  sections = {lualine_c = {require('auto-session-library').current_session_name}}
}
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
