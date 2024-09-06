
vim.keymap.set('n', '<Space><Space>', '<cmd>Telescope find_files<cr>', { desc = 'Find files with telescope' })
vim.keymap.set('n', '<C-Space>', '<cmd>Telescope<cr>', { desc = 'Open telescope' })
vim.keymap.set('n', '<S-Space>', vim.lsp.buf.hover, { desc = 'See LSP hover information' })
vim.keymap.set('n', '<Space><Return>', vim.lsp.buf.code_action, { desc = 'Show code actions' })
vim.keymap.set('n', '<Space>g', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', '<Space><Tab>', '<cmd>Neotree toggle<cr>', { desc = 'Toggle neotree visibility' })
