local lze = require("lze")

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

        local enabled = plugin.enabled
        if enabled == true then
            enabled = result
        end
        return plugin
    end,
})

lze.register_handlers({
    spec_field = "lsp",
    modify = function(plugin)
        if plugin.lsp == true then
            plugin.load = function(p)
                vim.lsp.enable(p)
            end
        end
        return plugin
    end,
})

lze.load({
    { import = "plugins.autopairs" },
    { import = "plugins.conform" },
    { import = "plugins.gitsigns" },
    -- { import = "plugins.lazydev" },
    { import = "plugins.lsp" },
    { import = "plugins.oil" },
    { import = "plugins.telescope" },
    { import = "plugins.vimtex" },
})
