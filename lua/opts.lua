-- opts
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.confirm = true
vim.opt.undofile = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 6

vim.opt.updatetime = 500
vim.opt.timeoutlen = 650

vim.opt.number = true
vim.opt.list = true
vim.opt.showmode = true
vim.opt.signcolumn = "yes"
vim.opt.showtabline = 2
vim.opt.virtualedit = "block"
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve-t:ver25,r-cr-o:hor20"

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
-- vim.opt.showbreak = "> "
vim.opt.smoothscroll = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

vim.opt.background = "dark"
vim.opt.termguicolors = true

-- netrw
vim.g.netrw_winsize = 25
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_keepdir = 0

vim.g.altv = true
vim.g.alto = true
vim.g.netrw_browse_split = 3

vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_localrmdir = "rm -r"

-- filetype opts
local ft_group = vim.api.nvim_create_augroup("filetype-opts", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "nix", "html", "css" },
    group = ft_group,
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
    end
})
