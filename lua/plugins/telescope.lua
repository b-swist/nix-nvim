return {
    "telescope.nvim",
    cmd = "Telescope",
    after = function()
        require("telescope").setup({})
        require("telescope").load_extension("fzf")
    end,
}
