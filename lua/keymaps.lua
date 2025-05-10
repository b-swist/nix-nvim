vim.g.mapleader = vim.keycode("<space>")
vim.g.maplocalleader = vim.keycode("<space>")

local opts = setmetatable({
    noremap = true,
    silent = true,
}, {
    __concat = function(t1, t2)
        local final = {}
        for k, v in pairs(t1) do
            final[k] = v
        end
        for k, v in pairs(t2) do
            final[k] = v
        end
        return final
    end,
})

vim.keymap.set("n", "<leader>r", "<cmd>luafile %<CR>", opts .. { desc = "Source current file" })
vim.keymap.set("x", "<leader>r", ":lua<CR>", opts .. { desc = "Source current selection" })

-- motions
vim.keymap.set({ "n", "x" }, "j", function()
    return vim.v.count == 0 and "gj" or "j"
end, opts .. { expr = true })
vim.keymap.set({ "n", "x" }, "k", function()
    return vim.v.count == 0 and "gk" or "k"
end, opts .. { expr = true })

vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", opts .. { desc = "Move selection down" })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", opts .. { desc = "Move selection up" })

vim.keymap.set({ "n", "x" }, "<C-h>", "<C-w>h", opts)
vim.keymap.set({ "n", "x" }, "<C-l>", "<C-w>l", opts)
vim.keymap.set({ "n", "x" }, "<C-j>", "<C-w>j", opts)
vim.keymap.set({ "n", "x" }, "<C-k>", "<C-w>k", opts)

vim.keymap.set("x", "<", "<gv", opts)
vim.keymap.set("x", ">", ">gv", opts)

vim.keymap.set("n", "<space>", "<nop>", opts)

-- tabs
for i = 1, 9 do
    vim.keymap.set("n", "<M-" .. i .. ">", i .. "gt", opts .. { desc = "Jump to tab #" .. i })
end
vim.keymap.set("n", "<leader>dt", "<cmd>tabclose<CR>", opts .. { desc = "Delete current tab" })

-- buffers
vim.keymap.set("n", "gb", "<cmd>bnext<CR>", opts .. { desc = "Jump to the next buffer" })
vim.keymap.set("n", "gD", "<cmd>bprev<CR>", opts .. { desc = "Jump to the previous buffer" })
vim.keymap.set("n", "<leader>db", "<cmd>bdel<CR>", opts .. { desc = "Delete current buffer" })

-- quickfix
vim.keymap.set({ "n", "i" }, "<M-j>", "<cmd>cnext<CR>", opts .. { desc = "Jump to the next quickfix item" })
vim.keymap.set({ "n", "i" }, "<M-k>", "<cmd>cprev<CR>", opts .. { desc = "Jump to the previous quickfix item" })

-- conform
local conform_keymap = require("lz.n").keymap("conform")
conform_keymap.set("n", "grf", require("conform").format, opts .. { desc = "Format current buffer" })

-- telescope
local telescope_keymap = require("lz.n").keymap("telescope")
local builtin = require("telescope.builtin")
telescope_keymap.set("n", "<leader>ff", builtin.find_files, opts .. { desc = "Search files" })
telescope_keymap.set("n", "<leader>fg", builtin.live_grep, opts .. { desc = "Search live grep" })
telescope_keymap.set("n", "<leader>fb", builtin.buffers, opts .. { desc = "Search buffers" })
telescope_keymap.set("n", "<leader>fr", builtin.registers, opts .. { desc = "Search registers" })
telescope_keymap.set("n", "<leader>fh", builtin.help_tags, opts .. { desc = "Search help pages" })
telescope_keymap.set("n", "<leader>ft", builtin.builtin, opts .. { desc = "Search Telescope builtins" })

-- oil
vim.keymap.set("n", "<leader>e", require("oil").open, opts .. { desc = "Open oil buffer" })

-- fterm
vim.keymap.set("n", "<leader>t", "<cmd>FTerm<CR>", opts .. { desc = "Toggle terminal" })
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", opts)

-- lsp and diagnostic
vim.api.nvim_create_autocmd("LspAttach", {
    group = require("lsp").on_attach,
    callback = function(event)
        local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

        vim.keymap.set("n", "gd", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, opts .. { buffer = event.buf, desc = "Jump to the next diagnostic message" })
        vim.keymap.set("n", "gD", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, opts .. { buffer = event.buf, desc = "Jump to the previous diagnostic message" })
        vim.keymap.set(
            "n",
            "<leader>c",
            vim.diagnostic.setloclist,
            opts .. { buffer = event.buf, desc = "Open quickfix diagnostic list" }
        )
        telescope_keymap.set("n", "<leader>fd", builtin.diagnostics, opts .. { desc = "Search diagnostics" })

        if client:supports_method("textDocument/definition") then
            vim.keymap.set(
                "n",
                "grd",
                vim.lsp.buf.definition,
                opts .. { buffer = event.buf, desc = "Jump to definition" }
            )
        end

        if client:supports_method("textDocument/declaration") then
            vim.keymap.set(
                "n",
                "grD",
                vim.lsp.buf.declaration,
                opts .. { buffer = event.buf, desc = "Jump to declaration" }
            )
        end

        if client:supports_method("textDocument/typeDefinition") then
            vim.keymap.set(
                "n",
                "grt",
                vim.lsp.buf.type_definition,
                opts .. { buffer = event.buf, desc = "Jump to type definition" }
            )
        end
    end,
})
