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
    let g:plugin_group = ['basic','enhanced','git','filetypes']
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
    Plug 'flazz/vim-colorschemes'
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
    " 文件浏览
    Plug 'preservim/nerdtree'
    " 模糊搜索
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    " Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
    " 自动补全括号等
    Plug 'jiangmiao/auto-pairs'
    Plug 'mbbill/undotree'
    " 异步语法检查
    Plug 'w0rp/ale'
    " 平滑滚动
    Plug 'terryma/vim-smooth-scroll'
    " Flutter
    Plug 'theniceboy/dart-vim-plugin'
    Plug 'thosakwe/vim-flutter'
    " 多彩括号
    Plug 'luochen1990/rainbow'
    Plug 'liuchengxu/vista.vim'
    " rust
    Plug 'rust-lang/rust.vim'

endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git增强
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if index(g:plugin_group,'git') >=0
    Plug 'tpope/vim-fugitive'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " 在sign列中显示git diff情况:添加,修改或删除的行
    Plug 'airblade/vim-gitgutter'
    Plug 'fszymanski/fzf-gitignore', {'do': ':UpdateRemotePlugins'}
    " NERDTree中显示git status的插件
    Plug 'Xuyuanp/nerdtree-git-plugin'
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
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Markdown
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if index(g:plugin_group,'git') >=0
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    Plug 'mzlogin/vim-markdown-toc'
endif


call plug#end()
