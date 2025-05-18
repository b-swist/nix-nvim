return {
    "telescope.nvim",
    category = "telescope",
    cmd = "Telescope",
    on_require = "telescope",
    load = function(name)
        vim.cmd.packadd(name)
        vim.cmd.packadd("telescope-fzf-native.nvim")
    end,
    after = function()
        require("telescope").setup({})
        require("telescope").load_extension("fzf")
    end,
}
