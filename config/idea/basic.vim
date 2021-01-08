"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 基本设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 禁用vi兼容模式
set nocompatible
" 开启功能键超时检测
set timeout
set timeoutlen=500
set ttimeoutlen=10
" 操作历史设置
set history=500
" 开启文件类型检测
filetype plugin on
filetype indent on
" 启用自动加载
set autoread
" 使用系统剪贴板
set clipboard+=unnamedplus
au FocusGained,BufEnter * checktime
" :W sudo保存文件
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
"记住退出位置
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" 保存时,删除尾随空格
if has("autocmd")
    au BufWritePre * %s/\s\+$//e
endif

" set search root directory for rg
if executable('rg')
    let g:rg_derive_root='true'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 备份设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set noswapfile

silent !mkdir -p ~/.nvim_runtime/tmp/backup
silent !mkdir -p ~/.nvim_runtime/tmp/undo
" silent !mkdir -p ~/.nvim_runtime/tmp/sessions
set backupdir=~/.nvim_runtime/tmp/backup,.
set directory=~/.nvim_runtime/tmp/backup,.
if has('persistent_undo')
    set undofile
    set undodir=~/.nvim_runtime/tmp/undo,.
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 界面设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示行号
set number
" 设置相对行号,便于跳转
set relativenumber
" 总是显示侧边栏（用于显示 mark/gitdiff/诊断信息）
set signcolumn=yes
" 显示标签栏
set showtabline=2
" 显示最后一行
set display=lastline
" 设置显示制表符等隐藏字符
set list
" 右下角显示命令
set showcmd
" 水平切割窗口时,默认在右边显示新窗口
set splitright
" Give more space for displaying messages
set cmdheight=2
set hid
" 延迟绘制（提升性能）
set lazyredraw
set magic
set showmatch
set mat=2
set foldcolumn=1
hi! FoldColumn guibg=NONE ctermbg=NONE
" 允许下方显示目录
set wildmenu
" 右下角显示命令
set showcmd
" 设置分隔符可视
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 搜索设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 搜索时忽略大小写
set ignorecase
" 搜索大小写判断,默认忽略大小写
set smartcase
" 高亮搜索内容
set hlsearch
" 输入查找内容时,动态显示结果
set incsearch

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 缩进设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 插入tab时展开为空格
set expandtab
" 如果后面设置了 expandtab 那么展开 tab 为多少字符
set softtabstop=4
set smarttab
set shiftwidth=4
set tabstop=4
set autoindent smartindent shiftround
" 打开C/C++语言缩进优化
set cindent

set lbr
set tw=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置Leader键
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
" 快速保存,使用<leader>w
nmap <leader>w :w!<cr>

noremap <LEADER>rc :e ~/.nvim_runtime/idea.vim<CR>
" undo
nnoremap U <C-r>

" 缩进后保持选中状态,方便后续继续缩进
vnoremap < <gv
vnoremap > >gv

" 行首&行尾,由于H/M/L原生表示为跳转到屏幕最上方/中间/最下方,因此屏蔽,使用原生^/$
" nnoremap H ^
" nnoremap L $
" 默认情况下,k为向下移动实际的一行,但更多情况下,我们期望该操作移动的是屏幕行,也就是使用gk,为了方便我们兑换这两个操作
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 可视模式
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode下使用*或#搜索当前选中内容
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 搜索
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <C-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Action配置(show all the provided acitons via :actionlist)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap \f : action ReformatCode <CR>
nnoremap <C-A-l> :action ReformatCode<CR>

nnoremap <Leader>su :action ShowUsages<CR>
nnoremap <Leader>fu :action FindUsages<CR>

" <C-P>
nnoremap <C-P> :action ParameterInfo<CR>
inoremap <C-P> <ESC>:action ParameterInfo<CR>a

noremap <C-f> :action SearchEverywhere<CR>
