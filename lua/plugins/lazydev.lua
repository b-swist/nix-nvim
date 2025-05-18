return {
    "lazydev.nvim",
    category = "lsp.lua",
    ft = "lua",
    after = function()
        ---@diagnostic disable-next-line: missing-fields
        require("lazydev").setup({
            library = {
                { path = nixCats.nixCatsPath .. "/lua", words = { "nixCats" } },
            },
            integrations = {
                cmp = false,
            },
        })
    end,
}
