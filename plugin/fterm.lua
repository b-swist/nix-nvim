local fterm = {
    win = -1,
    buf = -1,
}

vim.api.nvim_set_hl(0, "FTerm", { link = "Normal" })
vim.api.nvim_set_hl(0, "FTermBorder", { link = "Normal" })
vim.api.nvim_set_hl(0, "FTermTitle", { link = "Normal" })

function fterm:create_win()
    local width = math.floor(vim.o.columns * 0.6)
    local height = math.floor(vim.o.lines * 0.6)
    self.win = vim.api.nvim_open_win(self.buf, true, {
        relative = "editor",
        width = width,
        height = height,
        col = (vim.o.columns - width) / 2,
        row = (vim.o.lines - height) / 2,
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
        if vim.bo[self.buf].buftype ~= "terminal" then
            vim.cmd.term()
        end
        vim.cmd.startinsert()
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
