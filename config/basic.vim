"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 环境判断
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 判断系统类型
if(has('win32') || has('win64'))
    let g:isWIN = 1
    let g:isMAC = 0
else
    if system('uname') =~ 'Darwin'
        let g:isWIN = 0
        let g:isMAC = 1
    else
        let g:isWIN = 0
        let g:isMAC = 0
    endif
endif

" 判断是是否处于GUI界面
if has('gui_running')
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 基本设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 禁用vi兼容模式
set nocompatible
" 开启功能键超时检测
set ttimeout
set timeoutlen=50
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
" => 状态栏
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 开启状态栏标尺
set ruler
" 一直显示状态栏
set laststatus=2
set statusline=                                 " 清空状态了
set statusline+=\ %F                            " 文件名
set statusline+=\ [%1*%M%*%n%R%H]               " buffer 编号和状态
set statusline+=%=                              " 向右对齐
set statusline+=\ %y                            " 文件类型
" 最右边显示文件编码和行号等信息，并且固定在一个 group 中，优先占位
set statusline+=\ %0(%{&fileformat}\ [%{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %v:%l/%L%)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 编辑设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 开启语法提示
if has('syntax')
    syntax enable
    syntax on
endif
" 编码设置
if has('multi_byte')
    " 内部工作编码
    set encoding=utf-8
    " 文件默认编码
    set fileencoding=utf-8
    " 打开文件时自动尝试下面顺序的编码
    set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1
endif
" 折叠设置
if has('folding')
    " 允许代码折叠
    set foldenable
    " 代码折叠默认使用缩进
    set fdm=indent
    " 默认打开所有缩进
    set foldlevel=99
endif

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m
" 合并两行中文时，不在中间加空格
set formatoptions+=B
" 文件换行符，默认使用 unix 换行符
set ffs=unix,dos,mac

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
" => 错误提示
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" 错误格式
set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m

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
" => 终端设置,隐藏行号和侧边栏
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('terminal') && exists(':terminal') == 2
    if exists('##TerminalOpen')
        augroup VimUnixTerminalGroup
            au!
            au TerminalOpen * setlocal nonumber signcolumn=no
        augroup END
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => quickfix 设置，隐藏行号
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup VimInitStyle
    au!
    au FileType qf setlocal nonumber
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 标签栏最终设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 标签栏文字风格：默认为零，GUI 模式下空间大，按风格 3显示
" 0: filename.txt
" 2: 1 - filename.txt
" 3: [1] filename.txt
if has('gui_running')
    let g:config_vim_tab_style = 3
endif

" 终端下的 tabline
function! Vim_NeatTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif

        " set the tab page number (for mouse clicks)
        let s .= '%' . (i + 1) . 'T'

        " the label is made by MyTabLabel()
        let s .= ' %{Vim_NeatTabLabel(' . (i + 1) . ')} '
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let s .= '%=%#TabLine#%999XX'
    endif

    return s
endfunc

" 需要显示到标签上的文件名
function! Vim_NeatBuffer(bufnr, fullname)
    let l:name = bufname(a:bufnr)
    if getbufvar(a:bufnr, '&modifiable')
        if l:name == ''
            return '[No Name]'
        else
            if a:fullname
                return fnamemodify(l:name, ':p')
            else
                let aname = fnamemodify(l:name, ':p')
                let sname = fnamemodify(aname, ':t')
                if sname == ''
                    let test = fnamemodify(aname, ':h:t')
                    if test != ''
                        return '<'. test . '>'
                    endif
                endif
                return sname
            endif
        endif
    else
        let l:buftype = getbufvar(a:bufnr, '&buftype')
        if l:buftype == 'quickfix'
            return '[Quickfix]'
        elseif l:name != ''
            if a:fullname
                return '-'.fnamemodify(l:name, ':p')
            else
                return '-'.fnamemodify(l:name, ':t')
            endif
        else
        endif
        return '[No Name]'
    endif
endfunc

" 标签栏文字，使用 [1] filename 的模式
function! Vim_NeatTabLabel(n)
    let l:buflist = tabpagebuflist(a:n)
    let l:winnr = tabpagewinnr(a:n)
    let l:bufnr = l:buflist[l:winnr - 1]
    let l:fname = Vim_NeatBuffer(l:bufnr, 0)
    let l:num = a:n
    let style = get(g:, 'config_vim_tab_style', 0)
    if style == 0
        return l:fname
    elseif style == 1
        return "[".l:num."] ".l:fname
    elseif style == 2
        return "".l:num." - ".l:fname
    endif
    if getbufvar(l:bufnr, '&modified')
        return "[".l:num."] ".l:fname." +"
    endif
    return "[".l:num."] ".l:fname
endfunc

" GUI 下的标签文字，使用 [1] filename 的模式
function! Vim_NeatGuiTabLabel()
    let l:num = v:lnum
    let l:buflist = tabpagebuflist(l:num)
    let l:winnr = tabpagewinnr(l:num)
    let l:bufnr = l:buflist[l:winnr - 1]
    let l:fname = Vim_NeatBuffer(l:bufnr, 0)
    let style = get(g:, 'config_vim_tab_style', 0)
    if style == 0
        return l:fname
    elseif style == 1
        return "[".l:num."] ".l:fname
    elseif style == 2
        return "".l:num." - ".l:fname
    endif
    if getbufvar(l:bufnr, '&modified')
        return "[".l:num."] ".l:fname." +"
    endif
    return "[".l:num."] ".l:fname
endfunc

" 设置 GUI 标签的 tips: 显示当前标签有哪些窗口
function! Vim_NeatGuiTabTip()
    let tip = ''
    let bufnrlist = tabpagebuflist(v:lnum)
    for bufnr in bufnrlist
        " separate buffer entries
        if tip != ''
            let tip .= " \n"
        endif
        " Add name of buffer
        let name = Vim_NeatBuffer(bufnr, 1)
        let tip .= name
        " add modified/modifiable flags
        if getbufvar(bufnr, "&modified")
            let tip .= ' [+]'
        endif
        if getbufvar(bufnr, "&modifiable")==0
            let tip .= ' [-]'
        endif
    endfor
    return tip
endfunc

set tabline=%!Vim_NeatTabLine()
set guitablabel=%{Vim_NeatGuiTabLabel()}
set guitabtooltip=%{Vim_NeatGuiTabTip()}
