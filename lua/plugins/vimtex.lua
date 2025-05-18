return {
    "vimtex",
    category = "latex",
    lazy = false,
    before = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_compiler_latexmk = {
            aux_dir = "aux",
            out_dir = "out",
        }
    end,
}
