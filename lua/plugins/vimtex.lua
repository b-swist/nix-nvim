return {
    "vimtex",
    category = "latex",
    ft = "tex",
    before = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_compiler_latexmk = {
            aux_dir = "aux",
            out_dir = "out",
        }
    end,
}
