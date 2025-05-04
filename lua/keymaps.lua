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
vim.keymap.set("v", "<leader>r", ":lua<CR>", opts)

-- motions
vim.keymap.set({ "n", "v" }, "j", "gj", opts)
vim.keymap.set({ "n", "v" }, "k", "gk", opts)

vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("v", "J", ":m '>+1<CR>gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv", opts)

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
vim.keymap.set({ "n", "i" }, "<M-j>", "<cmd>cnexf<CR>", opts)
vim.keymap.set({ "n", "i" }, "<M-k>", "<cmd>cprev<CR>", opts)

--lsp
vim.keymap.set("n", "grd", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
vim.keymap.set("n", "grf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

-- diagnostics
vim.keymap.set("n", "gd", "<cmd>lua vim.diagnostic.jump({ count = 1, float = true })<CR>", opts)
vim.keymap.set("n", "gD", "<cmd>lua vim.diagnostic.jump({ count = -1, float = true })<CR>", opts)
vim.keymap.set("n", "<leader>cd", "<cmd>lua vim.diagnostic.setloclist()<CR>",
    opts .. { desc = "Qui[c]kfix [D]iagnostics" })

-- fterm
vim.keymap.set("n", "<leader>t", "<cmd>FTerm<CR>", opts .. { desc = "[T]erminal Toggle" })
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", opts)
