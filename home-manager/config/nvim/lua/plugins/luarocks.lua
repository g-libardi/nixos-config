return {
  "vhyrro/luarocks.nvim",
  priority = 10000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
  opts = {
    rocks = { "magick" },
  },
}
