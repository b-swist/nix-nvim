return {
    "oil.nvim",
    category = "general",
    event = "DeferredUIEnter",
    on_require = "oil",
    after = function()
        local oil = require("oil")
        oil.setup({
            -- columns = {},
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
