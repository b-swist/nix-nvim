vim.diagnostic.config({
    underline = {
        severity = vim.diagnostic.severity.ERROR,
    },
    virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "",
    },
    severity_sort = true,
    signs = true,
    float = {
        border = "rounded",
    },
})

local group = {
    attach = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    detach = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
    hl = vim.api.nvim_create_augroup("lsp-highlight-hover", { clear = false }),
}

vim.api.nvim_create_autocmd("LspAttach", {
    group = group.attach,
    callback = function(event)
        local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
        end

        if client:supports_method("textDocument/documentHighlight") then
            vim.api.nvim_create_autocmd("CursorHold", {
                buffer = event.buf,
                group = group.hl,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "ModeChanged" }, {
                buffer = event.buf,
                group = group.hl,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
})

vim.api.nvim_create_autocmd("LspDetach", {
    group = group.detach,
    callback = function(event)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds({
            group = group.hl,
            buffer = event.buf,
        })
        vim.api.nvim_clear_autocmds({
            group = group.attach,
            buffer = event.buf,
        })
    end,
})

return { on_attach = group.attach }
