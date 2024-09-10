-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)


vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Luarocks
-- opts.rocks.enabled = false

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- add your plugins here
        { import = 'plugins' },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- install missing on startup
    missing = true,
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "tokyonight-storm" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})


