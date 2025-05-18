return {
    "gitsigns.nvim",
    category = "general",
    after = function()
        require("gitsigns").setup({})
    end,
}
