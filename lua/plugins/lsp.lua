return {
    {
        "nvim-lspconfig",
        category = "lsp.general",
        cmd = {
            "LspInfo",
            "LspStart",
        },
        lsp = function(plugin)
            vim.lsp.config(plugin.name, plugin.lsp or {})
            vim.lsp.enable(plugin.name)
        end,
    },
    {
        "lua_ls",
        category = "lsp.lua",
        lsp = {
            filetypes = "lua",
            settings = {
                Lua = {
                    path = {
                        "lua/?.lua",
                        "lua/?/init.lua",
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME,
                            nixCats.nixCatsPath,
                        },
                    },
                },
            },
        },
    },
    {
        "nixd",
        category = "lsp.nix",
        lsp = {
            filetypes = "nix",
        },
    },
    {
        "hls",
        category = "lsp.haskell",
        lsp = {
            filetypes = "haskell",
        },
    },
}
