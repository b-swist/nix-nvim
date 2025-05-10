return {
    "lazydev",
    ft = "lua",
    after = function()
        require("lazydev").setup({
            integrations = {
                cmp = false,
            },
        })
    end,
}
