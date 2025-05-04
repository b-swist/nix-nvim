-- opts
vim.opt.clipboard = "unnamedplus"
vim.opt.confirm = true
vim.opt.mouse = "a"
vim.opt.undofile = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 6
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve-t:ver25,r-cr-o:hor20"
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.list = true
vim.opt.showtabline = 2
vim.opt.showmode = true

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
vim.opt.virtualedit = "block"

vim.opt.background = "dark"
vim.opt.termguicolors = true

-- misc
vim.diagnostic.config({ virtual_text = true })
