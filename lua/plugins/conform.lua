return {
    "conform",
    event = "BufWritePre",
    cmd = "ConformInfo",
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
