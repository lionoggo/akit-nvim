" coc自动补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 自动格式化
Plug 'Chiel92/vim-autoformat'
" 注释插件
Plug 'scrooloose/nerdcommenter'
" 自动补全括号等
Plug 'jiangmiao/auto-pairs'
" 多彩括号
" Plug 'luochen1990/rainbow'
" 异步语法检查
Plug 'w0rp/ale'
" 代码片段库,结合coc-snippets
Plug 'honza/vim-snippets'
" ctags生成tag
Plug 'universal-ctags/ctags'
" 底层利用ctags
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/asyncrun.vim'
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' }
" 笔记插件，支持markdown
Plug 'vimwiki/vimwiki'
Plug 'skywind3000/vim-terminal-help'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'github/copilot.vim'
