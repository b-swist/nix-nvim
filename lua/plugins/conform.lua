return {
    "conform.nvim",
    category = "format.general",
    event = "BufWritePre",
    cmd = "ConformInfo",
    on_require = "conform",
    after = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = nixCats("format.lua") and { "stylua" } or nil,
                nix = nixCats("format.nix") and { "alejandra" } or nil,
            },
            format_on_save = {
                lsp_format = "fallback",
            },
        })
    end,
}
