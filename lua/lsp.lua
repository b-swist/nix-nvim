vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true)
            }
        }
    }
})

vim.lsp.enable({ "nixd", "hls", "lua_ls" })

local group = {
    attach = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    detach = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
    hl = vim.api.nvim_create_augroup("lsp-highlight-hover", { clear = false }),
}

vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })

vim.api.nvim_create_autocmd("LspAttach", {
    group = group.attach,
    callback = function(event)
        local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

        vim.diagnostic.config({
            -- virtual_text = true,
            virtual_lines = true,
            severity_sort = true,
            signs = false,
            float = {
                border = "rounded"
            }
        })

        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = false })
        end

        if client:supports_method("textDocument/documentHighlight") then
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

        if not client:supports_method("textDocument/willSaveWaitUntil") and client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("lsp-format", { clear = false }),
                buffer = event.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = event.buf })
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
