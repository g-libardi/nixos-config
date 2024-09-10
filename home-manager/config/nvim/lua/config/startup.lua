-- Rodar comandos ao iniciar o Neovim
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
        vim.cmd("colorscheme catppuccin")
  end,
})
