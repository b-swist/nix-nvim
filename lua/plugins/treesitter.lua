return {
    "nvim-treesitter",
    lazy = vim.fn.argc(-1) == 0,
    event = "DeferredUIEnter",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    after = function()
        require("nvim-treesitter.configs").setup({
            highlight = {
                enable = true,
                disable = { "latex" },
            },
            indent = {
                enable = true,
            },
        })
    end,
}
