return {
    "oil.nvim",
    category = "general",
    lazy = vim.fn.argc(-1) == 0,
    event = "DeferredUIEnter",
    after = function()
        local oil = require("oil")
        oil.setup({
            default_file_explorer = true,
            skip_confirm_for_simple_edits = true,
            view_options = {
                show_hidden = true,
            },
            float = {
                max_width = 0.6,
                max_height = 0.6,
            },
            keymaps = {
                [".."] = { "actions.parent", mode = "n" },
                ["<leader>e"] = { "actions.close", mode = "n" },
            },
        })

        vim.keymap.set("n", "<leader>e", oil.open)
    end,
}
