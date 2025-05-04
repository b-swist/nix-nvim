local lspconfig = require("lspconfig")

lspconfig.nixd.setup({})
lspconfig.hls.setup({})
lspconfig.lua_ls.setup({
    settings = { Lua = { diagnostics = { globals = { "vim" } } } }
})
