require("opts")
require("lsp")
require("plugins")
require("keymaps")

local colorscheme = nixCats("colorscheme") or "quiet"
vim.cmd.colorscheme(colorscheme)

if colorscheme == "spaceduck" then
    vim.api.nvim_set_hl(0, "Conceal", { link = "Special" })
end

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("yank-highlight", { clear = true }),
    callback = function()
        vim.hl.on_yank({
            -- higroup = "Visual",
            timeout = 220,
        })
    end,
})
