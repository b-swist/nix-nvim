local fterm = {
    win = -1,
    buf = -1,
}

vim.api.nvim_set_hl(0, "FTerm", { link = "Normal" })
vim.api.nvim_set_hl(0, "FTermBorder", { link = "Normal" })
vim.api.nvim_set_hl(0, "FTermTitle", { link = "Normal" })

function fterm:create_win()
    local columns = vim.api.nvim_get_option_value("columns", { scope = "global" })
    local lines = vim.api.nvim_get_option_value("lines", { scope = "global" })

    local width = math.floor(columns * 0.6)
    local height = math.floor(lines * 0.6)
    self.win = vim.api.nvim_open_win(self.buf, true, {
        relative = "editor",
        width = width,
        height = height,
        col = (columns - width) / 2,
        row = (lines - height) / 2,
        style = "minimal",
        border = "rounded", -- none | single | double | rounded | solid | shadow
        title = { { "Terminal", "FTermTitle" } },
        title_pos = "center",
    })
    vim.api.nvim_set_option_value("winhl", "Normal:FTerm,FloatBorder:FTermBorder", { win = self.win })
end

function fterm:create_buf()
    self.buf = vim.api.nvim_create_buf(false, true)
end

function fterm:close()
    if vim.api.nvim_win_is_valid(self.win) then
        vim.api.nvim_win_hide(self.win)
    end
end

function fterm:toggle()
    if not vim.api.nvim_buf_is_valid(self.buf) then
        self:create_buf()
    end
    if not vim.api.nvim_win_is_valid(self.win) then
        self:create_win()
        if vim.api.nvim_get_option_value("buftype", { buf = self.buf }) ~= "terminal" then
            vim.cmd.term()
        end
        vim.cmd.startinsert()
        vim.api.nvim_set_option_value("buflisted", false, { buf = self.buf })

        vim.keymap.set("n", "<Esc>", function()
            fterm:close()
        end, { buffer = self.buf, noremap = true, silent = true })
    else
        vim.api.nvim_win_hide(self.win)
    end
end

vim.api.nvim_create_user_command("FTerm", function()
    fterm:toggle()
end, {})
