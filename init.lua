require("opts")
require("keymaps")
require("lsp")
require("plugins")

vim.cmd.colorscheme("evergarden")

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("yank-highlight", { clear = true }),
    callback = function()
        vim.hl.on_yank({
            higroup = "Visual",
            timeout = 200
        })
    end
})
