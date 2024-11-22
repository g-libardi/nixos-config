return {
    {
        "williamboman/mason.nvim",
        opts = {},
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls", "tsserver",
            },
        },
        config = function()
            require("mason-lspconfig").setup_handlers {
                function(server_name)
                    require("lspconfig")[server_name].setup {}
                end,
            }
        end
    },
    {
        "zapling/mason-lock.nvim", init = function()
            require("mason-lock").setup({
                lockfile_path = vim.fn.stdpath("config") .. "/mason-lock.json" -- (default)
            }) 
        end,
    },
    {
        "neovim/nvim-lspconfig",
    },
}
