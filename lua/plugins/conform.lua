local function set_formatter(ft, fmts)
    return nixCats("format." .. ft) and fmts or nil
end

return {
    "conform.nvim",
    category = "format.general",
    event = "BufWritePre",
    cmd = "ConformInfo",
    on_require = "conform",
    after = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = set_formatter("lua", { "stylua" }),
                nix = set_formatter("nix", { "alejandra" }),
                tex = set_formatter("latex", { "tex-fmt" }),
            },
            format_on_save = {
                lsp_format = "fallback",
            },
        })
    end,
}
