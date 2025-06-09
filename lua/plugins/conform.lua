local function set_formatter(ft, fmts)
    return nixCats("format." .. ft) and fmts or nil
end

return {
    "conform.nvim",
    category = "format.general",
    event = "BufWritePre",
    cmd = "ConformInfo",
    after = function()
        local conform = require("conform")

        vim.api.nvim_create_user_command("ConformDisable", function(args)
            if args.bang then
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, { bang = true })

        vim.api.nvim_create_user_command("ConformEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {})

        conform.setup({
            stop_after_first = true,
            formatters_by_ft = {
                lua = set_formatter("lua", { "stylua" }),
                nix = set_formatter("nix", { "alejandra", "nixfmt" }),
                tex = set_formatter("latex", { "tex-fmt" }),
            },
            format_on_save = function(bufnr)
                local disabled_ft = {}
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { lsp_format = disabled_ft[vim.bo[bufnr].filetype] and "never" or "fallback" }
            end,
        })

        vim.keymap.set("n", "grf", conform.format)
    end,
}
