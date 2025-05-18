return {
    {
        "nvim-lspconfig",
        category = "lsp.general",
        cmd = {
            "LspInfo",
            "LspLog",
            "LspRestart",
            "LspStart",
            "LspStop",
        },
        dep_of = { "lua_ls", "nixd", "hls" },
    },
    {
        "lua_ls",
        category = "lsp.lua",
        ft = "lua",
        lsp = true,
    },
    {
        "nixd",
        category = "lsp.nix",
        ft = "nix",
        lsp = true,
    },
    {
        "hls",
        category = "lsp.haskell",
        ft = { "haskell", "lhaskell" },
        lsp = true,
    },
}
