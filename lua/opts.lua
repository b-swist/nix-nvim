-- opts
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.o.confirm = true
vim.o.undofile = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.scrolloff = 6
vim.o.exrc = true

vim.o.updatetime = 500
vim.o.timeoutlen = 650

vim.o.number = true
vim.o.relativenumber = true
vim.o.list = true
vim.o.listchars = "tab:> ,trail:-,nbsp:."
vim.o.showmode = true
vim.o.signcolumn = "yes"
vim.o.showtabline = 1
vim.o.virtualedit = "block"
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve-t:ver25,r-cr-o:hor20"

vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true
-- vim.o.showbreak = "> "
vim.o.smoothscroll = true

vim.o.tabstop = 4
vim.o.shiftwidth = 0
vim.o.softtabstop = -1
vim.o.expandtab = true
vim.o.smarttab = true

vim.o.autoindent = true
vim.o.smartindent = true

vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "split"

vim.o.background = "dark"
vim.o.termguicolors = true

-- filetype opts
local ft_group = vim.api.nvim_create_augroup("filetype-opts", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "nix", "html", "css" },
    group = ft_group,
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",
    group = ft_group,
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
        vim.opt_local.smartindent = true
        vim.opt_local.conceallevel = 2
        vim.g.tex_conceal = "abdmg"
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    group = ft_group,
    callback = function()
        vim.opt_local.expandtab = false
    end,
})
