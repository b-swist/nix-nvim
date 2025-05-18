return {
    "nvim-autopairs",
    category = "general",
    event = "InsertEnter",
    after = function()
        require("nvim-autopairs").setup()
    end,
}
