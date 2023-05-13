"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 基本设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 禁用vi兼容模式
set nocompatible
" 开启功能键超时检测
set timeout
set timeoutlen=500
set ttimeoutlen=50

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
" => 窗口切换
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

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
nmap <Leader>w :w!<cr>

noremap <Leader>rc :e ~/.nvim_runtime/idea.vim<CR>
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
" => Action配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Code Format
nnoremap \f :action ReformatCode<CR>
vnoremap \f :action ReformatCode<CR>
nnoremap <C-A-l> :action ReformatCode<CR>
" Code Write
nnoremap <Leader>cc :action CommentByLineComment<CR>
nnoremap <Leader>im :action ImplementMethods<CR>

" Code Refactor
nnoremap <Leader>oi :action OptimizeImports<CR>
nnoremap <Leader>sw :action SurroundWith<CR>

nnoremap <Leader>g :action Generate<CR>
vnoremap <Leader>g :action Generate<CR>
nnoremap <Leader>if :action IntroduceField<CR>
vnoremap <Leader>if :action IntroduceField<CR>
nnoremap <Leader>ic :action IntroduceConstant<CR>
vnoremap <Leader>ic :action IntroduceConstant<CR>
nnoremap <Leader>iv :action IntroduceVariable<CR>
vnoremap <Leader>iv :action IntroduceVariable<CR>
nnoremap <Leader>em :action ExtractMethod<CR>
vnoremap <Leader>em :action ExtractMethod<CR>
nnoremap <Leader>re :action RenameElement<CR>
vnoremap <Leader>re :action RenameElement<CR>
" in edit mode, press leader will print ',', so it not work
" nnoremap <Leader>v :action IntroduceVariable<CR>

" in macos, Cmd+P: show ParameterInfo
" inoremap <C-p> :action ParameterInfo<CR>
" inoremap <C-p> <ESC>:action ParameterInfo<CR>


" Search
" 和打开文件列表有冲突
" nnoremap <Leader>nf :action RenameFile<CR>

" Code view
nnoremap <silent> K :action QuickJavaDoc<CR>

" go to somewhere ( g in normal mode for go somewhere )
nnoremap ga :<C-u>action GotoAction<CR>
nnoremap gb :<C-u>action JumpToLastChange<CR>
nnoremap gc :<C-u>action GotoClass<CR>
nnoremap gd :<C-u>action GotoDeclaration<CR>
nnoremap gs :<C-u>action GotoSuperMethod<CR>
nnoremap gi :<C-u>action GotoImplementation<CR>
nnoremap gf :<C-u>action GotoFile<CR>
nnoremap gm :<C-u>action GotoSymbol<CR>
" search
nnoremap <C-p> :action SearchEverywhere<CR>
nnoremap <C-f> :action FindInPath<CR>
" nnoremap gp :action FindInPath<CR>

nnoremap <Leader>su :action ShowUsages<CR>
nnoremap <Leader>fu :action FindUsages<CR>

nnoremap <silent> <Leader>tt :action FileStructurePopup<CR>
nnoremap <silent> <leader>nf :action SelectInProjectView<CR>

" Code Debugger
nnoremap <Leader>dd :action ChooseDebugConfiguration<CR>
nnoremap <Leader>ba :action ToggleLineBreakpoint<CR>
nnoremap <Leader>bv :action ViewBreakpoints<CR>

" window
nnoremap <silent> <Leader>nn :action ActivateProjectToolWindow<CR>
nnoremap <Leader>ww :action WindowMenu<CR>
nnoremap <Leader>wf :action HideAllWindows<CR>
" make editor full screen
nnoremap <Leader>ef :action MaximizeEditorInSplit<CR>
" nnoremap <Leader>wF :action ToggleFullScreen<CR>
nnoremap <Leader>ws :action HideSideWindows<CR>
nnoremap <Leader>wl :action JumpToLastWindow<CR>
" nnoremap <Leader>w- :action VimWindowSplitHorizontal<CR>
nnoremap <Leader>sp :action SplitHorizontally<CR>
" nnoremap <Leader>/ :action VimWindowSplitHorizontal<CR>
nnoremap <Leader>vsp :action SplitVertically<CR>

cmap q action CloseEditor


" Terminal
" In normal vim, use alt+= to trigger
nnoremap <Leader>' :action ActivateTerminalToolWindow<CR>

" Vcs&Git配置
nnoremap <Leader>gg :action Git.Menu<CR>
nnoremap <Leader>gb :action Git.Branches<CR>
nnoremap <Leader>glf :action Vcs.ShowTabbedFileHistory<CR>
nnoremap <Leader>gls :action Vcs.ShowHistoryForBlock<CR>
" use t as prefix to toggle something
nnoremap ta :action Annotation<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Idea Plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ideaVimExtention
set keep-english-in-normal-and-restore-in-insert

" AceJump
" Press `f` to activate AceJump
map f :action AceAction<CR>
" Press `F` to activate Target Mode
map F :action AceTargetAction<CR>
" Press `g` to activate Line Mode
" map g :action AceLineAction<CR>
