return {
    {
        'goolord/alpha-nvim',
        dependencies = {
            'echasnovski/mini.icons',
            'nvim-lua/plenary.nvim'
        },
        priority = 900,
        config = function ()
            require'alpha'.setup(require'alpha.themes.theta'.config)
        end
    },
    {
        "olimorris/persisted.nvim",
        lazy = true, -- make sure the plugin is always loaded at startup
        config = true,
    },
}
