vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = {
    noremap = true,
    silent = true
}

setmetatable(opts, {
    __concat = function(t1, t2)
        local final = {}
        for k, v in pairs(t1) do
            final[k] = v
        end
        for k, v in pairs(t2) do
            final[k] = v
        end
        return final
    end
})

vim.keymap.set("n", "<leader>r", "<cmd>luafile %<CR>", opts)
vim.keymap.set("x", "<leader>r", ":lua<CR>", opts)

-- motions
vim.keymap.set({ "n", "x" }, "j", "gj", opts)
vim.keymap.set({ "n", "x" }, "k", "gk", opts)

vim.keymap.set({ "n", "x" }, "<C-h>", "<C-w>h", opts)
vim.keymap.set({ "n", "x" }, "<C-l>", "<C-w>l", opts)
vim.keymap.set({ "n", "x" }, "<C-j>", "<C-w>j", opts)
vim.keymap.set({ "n", "x" }, "<C-k>", "<C-w>k", opts)

vim.keymap.set("x", "<", "<gv", opts)
vim.keymap.set("x", ">", ">gv", opts)
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", opts)

-- tabs
vim.keymap.set("n", "<leader>dt", "<cmd>tabclose<CR>", opts .. { desc = "[D]elete [T]ab" })
for i = 1, 9 do
    vim.keymap.set("n", "<M-" .. i .. ">", i .. "gt", opts)
end

-- buffers
vim.keymap.set("n", "gb", "<cmd>bnext<CR>", opts)
vim.keymap.set("n", "gB", "<cmd>bprev<CR>", opts)
vim.keymap.set("n", "<leader>db", "<cmd>bdel<CR>", opts .. { desc = "[D]elete [B]uffer" })

-- quickfix
vim.keymap.set({ "n", "i" }, "<M-j>", "<cmd>cnext<CR>", opts)
vim.keymap.set({ "n", "i" }, "<M-k>", "<cmd>cprev<CR>", opts)

-- lsp and diagnostic
vim.api.nvim_create_autocmd("LspAttach", {
    group = require("lsp").on_attach,
    callback = function(event)
        vim.keymap.set("n", "grd", vim.lsp.buf.definition, opts .. { buffer = event.buf })
        vim.keymap.set("n", "grD", vim.lsp.buf.declaration, opts .. { buffer = event.buf })
        vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, opts .. { buffer = event.buf })
        vim.keymap.set("n", "grf", vim.lsp.buf.format, opts .. { buffer = event.buf })

        vim.keymap.set("n", "gd", function() vim.diagnostic.jump({ count = 1, float = true }) end,
            opts .. { buffer = event.buf })
        vim.keymap.set("n", "gD", function() vim.diagnostic.jump({ count = -1, float = true }) end,
            opts .. { buffer = event.buf })
        vim.keymap.set("n", "<leader>c", vim.diagnostic.setloclist,
            opts .. { buffer = event.buf, desc = "Qui[c]kfix Diagnostics" })
    end
})

-- netrw
vim.keymap.set("n", "<leader>f", "<cmd>Lexplore<CR>", opts .. { desc = "Open [F]ile Tree" })

-- fterm
vim.keymap.set("n", "<leader>t", "<cmd>FTerm<CR>", opts .. { desc = "[T]erminal Toggle" })
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", opts)
