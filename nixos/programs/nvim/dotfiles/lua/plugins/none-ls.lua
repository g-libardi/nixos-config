return {
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                -- sources = {
                    -- null_ls.builtins.formatting.stylua,
                    -- null_ls.builtins.formatting.prettier,
                    -- null_ls.builtins.diagnostics.eslint,
                    -- null_ls.builtins.completion.spell,
                    -- require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
                -- },
            })
        end,
    },
    {
        "zeioth/none-ls-autoload.nvim",
        event = "BufEnter",
        dependencies = {
            "williamboman/mason.nvim",
            "zeioth/none-ls-external-sources.nvim" -- To install a external sources library.
        },
        opts = {
            external_sources = {
                -- To specify where to find a external source.
                -- ex: 'none-ls-external-sources.formatting.reformat_gherkin'
            },
        },
    },
}
