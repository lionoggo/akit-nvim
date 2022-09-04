Plug 'tpope/vim-fugitive'
" 在sign列中显示git diff情况:添加,修改或删除的行
" Plug 'airblade/vim-gitgutter'
if has('nvim') || has('patch-8.0.902')
    Plug 'mhinz/vim-signify'
else
    Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
Plug 'fszymanski/fzf-gitignore', {'do': ':UpdateRemotePlugins'}
" NERDTree中显示git status的插件
Plug 'Xuyuanp/nerdtree-git-plugin'
" 分支管理
Plug 'stsewd/fzf-checkout.vim'
