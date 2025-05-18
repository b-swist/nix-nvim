return {
    {
        "nvim-lspconfig",
        category = "lsp.general",
        lazy = false,
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
