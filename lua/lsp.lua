local servers = {
    nixd = {},
    hls = {},
    lua_ls = {
        settings = {
            Lua = {
                -- diagnostics = {
                --     globals = { "vim" }
                -- },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true)
                }
            }
        }
    }
}

for server, settings in pairs(servers) do
    require("lspconfig")[server].setup(settings)
end

local group = {
    attach = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    detach = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
    format = vim.api.nvim_create_augroup("lsp-format", { clear = false }),
    hl = vim.api.nvim_create_augroup("lsp-highlight-hover", { clear = false }),
}

vim.api.nvim_create_autocmd("LspAttach", {
    group = group.attach,
    callback = function(event)
        vim.diagnostic.config({ virtual_text = true })

        local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, event.buf)
        end

        if client:supports_method("textDocument/documentHighlight", event.buf) then
            vim.api.nvim_create_autocmd("CursorHold", {
                buffer = event.buf,
                group = group.hl,
                callback = vim.lsp.buf.document_highlight
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = group.hl,
                callback = vim.lsp.buf.clear_references
            })
        end

        if client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = group.format,
                buffer = event.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
                end,
            })
        end
    end
})

vim.api.nvim_create_autocmd("LspDetach", {
    group = group.detach,
    callback = function(event)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds({
            group = group.hl,
            buffer = event.buf
        })
    end
})

return { on_attach = group.attach }
