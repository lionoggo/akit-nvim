""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 首次使用自动加载
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.nvim_runtime/autoload/plug.vim'))
    silent !curl -fLo ~/.nvim_runtime/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 分组加载插件
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:plugin_group')
    let g:plugin_group = ['basic','enhanced','git','filetypes','themes','markdown']
endif

" 在~/.config/nvim/plugged下安装插件
call plug#begin('~/.nvim_runtime/plugged')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 基本插件
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if index(g:plugin_group,'basic') >=0
    " 展示开始画面，显示最近编辑过的文件
    Plug 'mhinz/vim-startify'
    " 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
    Plug 'kshenoy/vim-signature'
    " vim中文文档
    Plug 'yianwillis/vimcdoc'
    Plug 'tpope/vim-surround'
    " 主题库
    Plug 'flazz/vim-colorschemes'
    " 文件浏览
    Plug 'preservim/nerdtree'
    " 模糊搜索
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    " Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
    Plug 'mbbill/undotree'
    " 平滑滚动
    Plug 'terryma/vim-smooth-scroll'
    " vim启动界面
    Plug 'liuchengxu/vista.vim'
    " 查看启动时间
    Plug 'dstein64/vim-startuptime', {'on':'StartupTime'}
    " Plug 'mg979/vim-visual-multi', {'branch': 'master'}
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 增强扩展插件
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if index(g:plugin_group,'enhanced') >=0
    " coc自动补全
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " 自动格式化
    Plug 'Chiel92/vim-autoformat'
    " 注释插件
    Plug 'scrooloose/nerdcommenter'
    " 自动补全括号等
    Plug 'jiangmiao/auto-pairs'
    " 多彩括号
    Plug 'luochen1990/rainbow'
    " 异步语法检查
    Plug 'w0rp/ale'
    " 代码片段库,结合coc-snippets
    Plug 'honza/vim-snippets'
    " Flutter
    Plug 'theniceboy/dart-vim-plugin'
    Plug 'thosakwe/vim-flutter'
    " ctags生成tag
    Plug 'universal-ctags/ctags'
    " 底层利用ctags
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'skywind3000/asyncrun.vim'
    Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' }
    " 笔记插件，支持markdown
    Plug 'vimwiki/vimwiki'
    Plug 'skywind3000/vim-terminal-help'
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git增强
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if index(g:plugin_group,'git') >=0
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
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => themes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if index(g:plugin_group,'themes') >=0
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Plug 'bling/vim-bufferline'
    Plug 'ryanoasis/vim-devicons'
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 文件类型扩展
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if index(g:plugin_group,'filetypes') >=0
    " powershell脚本文件的语法高亮
    Plug 'pprovost/vim-ps1', { 'for': 'ps1' }

    " C++ 语法高亮增强,支持11/14/17
    Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }

    " 额外语法文件
    Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'bison', 'flex', 'cpp'] }

    " rust语法增强
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }

    " 其他语法文件
    Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'bison', 'flex', 'cpp'] }
    " Vim多语言包
    Plug 'sheerun/vim-polyglot'
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Markdown
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if index(g:plugin_group,'markdown') >=0
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    Plug 'mzlogin/vim-markdown-toc'
endif

call plug#end()
