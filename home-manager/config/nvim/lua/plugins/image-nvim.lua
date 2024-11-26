return {
    {
        "3rd/image.nvim",
        build = false,
        dependencies = {
            "kiyoon/magick.nvim",
        },
        opts = {},
        config = function()
            require("image").setup({
                processor = "magick_cli",
            })
        end,
    },
}
