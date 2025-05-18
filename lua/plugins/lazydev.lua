return {
    "lazydev.nvim",
    category = "lsp.lua",
    ft = "lua",
    after = function()
        require("lazydev").setup({
            integrations = {
                cmp = false,
            },
        })
    end,
}
