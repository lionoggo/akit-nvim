""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " => 首次使用自动加载
 """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.nvim_runtime/autoload/plug.vim'))
        silent !curl -fLo ~/.nvim_runtime/autoload/plug.vim --create-dirs
                                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" 分组加载插件
if !exists('g:plugin_group')
	let g:plugin_group = ['basic','enhanced','git']
endif
" 在~/.config/nvim/plugged下安装插件
call plug#begin('~/.nvim_runtime/plugged')

" 基本插件设置
if index(g:plugin_group,'basic') >=0
	" 展示开始画面，显示最近编辑过的文件
	Plug 'mhinz/vim-startify'
	" 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
	Plug 'kshenoy/vim-signature'
	" vim中文文档
	Plug 'yianwillis/vimcdoc'
	Plug 'tpope/vim-surround'
endif

" 增强扩展插件
if index(g:plugin_group,'enhanced') >=0
	" coc自动补全
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	" 自动格式化
	Plug 'Chiel92/vim-autoformat'
	" vim启动页
	Plug 'mhinz/vim-startify'
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

endif

" git设置
if index(g:plugin_group,'git') >=0
    Plug 'tpope/vim-fugitive'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
    Plug 'airblade/vim-gitgutter'
    Plug 'fszymanski/fzf-gitignore', {'do': ':UpdateRemotePlugins'}
    " NERDTree中显示git status的插件
    Plug 'Xuyuanp/nerdtree-git-plugin'
endif

call plug#end()
