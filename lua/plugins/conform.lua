return {
    "conform.nvim",
    category = "format.general",
    event = "BufWritePre",
    cmd = "ConformInfo",
    on_require = "conform",
    after = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                nix = { "alejandra" },
            },
            format_on_save = {
                lsp_format = "fallback",
            },
        })
    end,
}
