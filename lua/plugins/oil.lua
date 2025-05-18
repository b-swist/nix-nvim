return {
    "oil.nvim",
    category = "general",
    event = "DeferredUIEnter",
    on_require = "oil",
    after = function()
        require("oil").setup({
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
            },
        })
    end,
}
