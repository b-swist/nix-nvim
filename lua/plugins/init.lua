return {
    {
        "spaceduck",
        colorsheme = "spaceduck",
    },
    {
        "gitsigns.nvim",
        after = function()
            require("gitsigns").setup({})
        end,
    },
}
