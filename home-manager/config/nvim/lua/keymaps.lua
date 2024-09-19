
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set('n', '<leader><leader>', '<cmd>Telescope find_files<cr>', { desc = 'Find files with telescope' })
vim.keymap.set('n', '<C-leader>', '<cmd>Telescope<cr>', { desc = 'Open telescope' })
vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, { desc = 'See LSP hover information' })
vim.keymap.set('n', '<leader><Return>', vim.lsp.buf.code_action, { desc = 'Show code actions' })
vim.keymap.set('n', '<leader>g', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', '<leader><Tab>', '<cmd>Neotree toggle<cr>', { desc = 'Toggle neotree visibility' })

-- show sessions in telescope
vim.keymap.set('n', '<leader>s', '<cmd>Telescope persisted<CR>', { desc = 'Show session from telescope' })

-- window navigation
vim.keymap.set('n', '<A-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<A-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<A-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<A-l>', ':wincmd l<CR>')
vim.keymap.set('n', '<A-Up>', ':wincmd k<CR>')
vim.keymap.set('n', '<A-Down>', ':wincmd j<CR>')
vim.keymap.set('n', '<A-Left>', ':wincmd h<CR>')
vim.keymap.set('n', '<A-Right>', ':wincmd l<CR>')
