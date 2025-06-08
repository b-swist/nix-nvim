local lze = require("lze")

lze.register_handlers(require("lzextras").lsp)

---@diagnostic disable: undefined-field
lze.register_handlers({
    spec_field = "category",
    set_lazy = false,
    modify = function(plugin)
        local field = plugin.category
        if type(field) ~= "table" then
            field = { field }
        end

        local result = false
        for _, category in ipairs(field) do
            if nixCats(category) then
                result = true
                break
            end
        end

        plugin.enabled = result
        return plugin
    end,
})

lze.load({
    { import = "plugins.autopairs" },
    { import = "plugins.conform" },
    { import = "plugins.gitsigns" },
    { import = "plugins.lsp" },
    { import = "plugins.oil" },
    { import = "plugins.snippy" },
    { import = "plugins.telescope" },
    { import = "plugins.treesitter" },
    { import = "plugins.vimtex" },
})
