
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- lsp related
vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, { desc = 'See LSP hover information' })
vim.keymap.set('n', '<leader><Return>', vim.lsp.buf.code_action, { desc = 'Show code actions' })
vim.keymap.set('n', '<leader>g', vim.lsp.buf.definition, { desc = 'Go to definition' })

-- copy paste
vim.keymap.set('v', '<C-S-c>', '<cmd>echo "Copied to clipboard"<cr>"+y', { desc = 'Copy to clipboard' })
vim.keymap.set('n', '<C-S-c>', '<cmd>echo "Copied to clipboard"<cr>', { desc = 'Copy to clipboard' })

-- file navigation
vim.keymap.set('n', '<leader><Tab>', '<cmd>Neotree toggle<cr>', { desc = 'Toggle neotree visibility' })

-- telescope
vim.keymap.set('n', '<leader>s', '<cmd>Telescope persisted<CR>', { desc = 'Show session from telescope' })
vim.keymap.set('n', '<leader>f', '<cmd>Telescope find_files<cr>', { desc = 'Find files with telescope' })
vim.keymap.set('n', '<leader><leader>', '<cmd>Telescope<cr>', { desc = 'Open telescope' })

-- window navigation
vim.keymap.set('n', '<A-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<A-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<A-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<A-l>', ':wincmd l<CR>')
vim.keymap.set('n', '<A-Up>', ':wincmd k<CR>')
vim.keymap.set('n', '<A-Down>', ':wincmd j<CR>')
vim.keymap.set('n', '<A-Left>', ':wincmd h<CR>')
vim.keymap.set('n', '<A-Right>', ':wincmd l<CR>')


-- jupyter notebooks
vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>",
    { silent = true, desc = "Initialize the plugin" })
vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>",
    { silent = true, desc = "run operator selection" })
vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>",
    { silent = true, desc = "evaluate line" })
vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>",
    { silent = true, desc = "re-evaluate cell" })
vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv",
    { silent = true, desc = "evaluate visual selection" })
