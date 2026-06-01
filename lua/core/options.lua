local opt = vim.opt

-- General
opt.history = 500
opt.autoread = true
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.updatetime = 100
opt.timeoutlen = 500
opt.shortmess:append("c")
opt.autowrite = true
opt.sessionoptions:append("globals")

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.showtabline = 2
opt.display = "lastline"
opt.list = true
opt.listchars = { tab = "| ", trail = "·", extends = ">", precedes = "<" }
opt.showcmd = true
opt.splitright = true
opt.splitbelow = true
opt.cmdheight = 0

opt.showmatch = true
opt.matchtime = 2
opt.wildmenu = true
opt.termguicolors = true
opt.cursorline = true
opt.scrolloff = 5

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Indent
opt.expandtab = true
opt.softtabstop = 4
opt.smarttab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.autoindent = true
opt.smartindent = true
opt.shiftround = true

-- Line wrapping
opt.linebreak = true
opt.textwidth = 500

-- Backup (disabled, use undofile instead)
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- Encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileencodings = { "ucs-bom", "utf-8", "gbk", "gb18030", "big5", "euc-jp", "latin1" }

-- Fold
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99

-- Formatting (Chinese text)
opt.formatoptions:append("m")
opt.formatoptions:append("B")
opt.fileformats = { "unix", "dos", "mac" }

-- Error bells
opt.errorbells = false
opt.visualbell = false

-- Wildignore
opt.wildignore:append({
  "*.o", "*.obj", "*~", "*.exe", "*.a", "*.pdb", "*.lib",
  "*.so", "*.dll", "*.swp", "*.egg", "*.jar", "*.class",
  "*.pyc", "*.pyo", "*.bin", "*.dex",
  "*.zip", "*.7z", "*.rar", "*.gz", "*.tar", "*.gzip",
  "*.png", "*.jpg", "*.gif", "*.bmp", "*.tga", "*.ico",
  "*.pdf", "*.dmg", "*.mp4", "*.avi", "*.flv", "*.mov",
  "*DS_Store*", ".git", ".hg", ".svn",
})
