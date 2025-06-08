return {
    "nvim-autopairs",
    category = "general",
    event = "InsertEnter",
    after = function()
        local autopairs, rule = require("nvim-autopairs"), require("nvim-autopairs.rule")

        autopairs.setup({
            disable_filetype = { "TelescopePrompt", "oil" },
        })

        table.insert(autopairs.get_rules("'")[1].not_filetypes, "tex")

        autopairs.add_rules({
            rule("$", "$", "tex"):with_move(function(opts)
                return opts.next_char == opts.char
            end),
            rule("|", "|", "tex"):with_move(function(opts)
                return opts.next_char == opts.char
            end):with_pair(function()
                return vim.fn["vimtex#syntax#in_mathzone"]() == 1
            end),
        })
    end,
}
