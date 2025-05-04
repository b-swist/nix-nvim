-- language-specific options
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "nix", "html", "css" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt.expandtab = true
    end
})

-- yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("yank-highlight", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})
