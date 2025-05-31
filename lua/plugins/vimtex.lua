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

        vim.g.vimtex_syntax_conceal = {
            accents = 1,
            ligatures = 1,
            cites = 1,
            fancy = 1,
            spacing = 1,
            greek = 1,
            math_bounds = 1,
            math_delimiters = 1,
            math_fracs = 0,
            math_super_sub = 0,
            math_symbols = 1,
            sections = 0,
            styles = 1,
        }
    end,
}
