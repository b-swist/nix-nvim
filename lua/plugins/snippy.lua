return {
    "nvim-snippy",
    category = "snippets",
    event = "InsertEnter",
    ft = { "snippet", "snippets" },
    after = function()
        require("snippy").setup({
            -- snippet_dirs = nixCats.configDir,
            enable_auto = true,
            expand_options = {
                m = function()
                    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
                end,
            },

            mappings = {
                i = {
                    ["<C-s>"] = "expand",
                    ["<Tab>"] = "next",
                    ["<S-Tab>"] = "previous",
                },
            },
        })

        vim.api.nvim_create_autocmd("CompleteDone", {
            group = vim.api.nvim_create_augroup("snippy", { clear = true }),
            callback = function()
                require("snippy").complete_done()
            end,
        })
    end,
}
