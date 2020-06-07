"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置Leader键
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
" 快速保存,使用<leader>w
nmap <leader>w :w!<cr>
" 选中全文
" map <leader>sa ggVG
" 快速打开init.vim配置
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>
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
" => 窗口管理设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 拼写检查
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  编译运行
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 不能映射成r键,和vim自带的字符替换r冲突
noremap <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        set splitbelow
        exec "!g++ -std=c++11 % -Wall -o %<"
        :sp
        :res -15
        :term ./%<
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        set splitbelow
        :sp
        :term python3 %
    elseif &filetype == 'html'
        silent! exec "!".g:mkdp_browser." % &"
    elseif &filetype == 'markdown'
        exec "MarkdownPreview"
    elseif &filetype == 'tex'
        silent! exec "VimtexStop"
        silent! exec "VimtexCompile"
    elseif &filetype == 'dart'
        CocCommand flutter.run -d iPhone\ 11\ Pro
        CocCommand flutter.dev.openDevLog
    elseif &filetype == 'javascript'
        set splitbelow
        :sp
        :term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
    elseif &filetype == 'go'
        set splitbelow
        :sp
        :term go run .
    elseif &filetype == 'rust'
        CocCommand rust-analyzer.run
    endif
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>
" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>
" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

