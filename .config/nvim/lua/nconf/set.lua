-- (./lua/nconf/set.lua)

-- common editor stuff
vim.opt.tabstop = 8
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.errorbells = false
vim.opt.modeline = true
vim.opt.linespace = 0
vim.opt.linespace = 0
vim.opt.joinspaces = false

-- go to new pane after a split
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.list = true
vim.opt.listchars = "tab:>-,trail:~,extends:>,precedes:<"

vim.opt.number = true
vim.opt.ruler = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.textwidth = 0
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes:1"
vim.opt.scrolloff = 8
vim.opt.so = 5
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.startofline = false

-- backup stuff
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- undo / clipboard stuff
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true
vim.opt.clipboard = "unnamed"

-- search options
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true

-- color / schedme options
vim.opt.background = "dark"
vim.opt.termguicolors = true

-- disable mouse
vim.opt.mouse = ""
vim.opt.mousescroll = "ver:0,hor:0"

-- automatic comment insertion
vim.cmd([[autocmd FileType * set formatoptions+=o]])
