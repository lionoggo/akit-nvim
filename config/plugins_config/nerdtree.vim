"-----------------------------------------------------------------------------
" 全局配置
"-----------------------------------------------------------------------------
let NERDTreeMinimalUI = 1 " 最小化显示，不显示问号
let NERDTreeDirArrows = 1
let NERDChristmasTree = 1

let g:NERDTreeWinPos = "left"
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
let g:plug_window = 'noautocmd vertical topleft new'
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1
" 显示行号
let NERDTreeShowLineNumbers=1
" 进入目录自动将workspace更改为此目录
let g:NERDTreeChDirMode = 2

" " 水平或者垂直窗口打开
" let g:NERDTreeMapOpenSplit = "w"
" let g:NERDTreeMapOpenVSplit = "W"
" 展开与关闭节点或者打开文件
let g:NERDTreeMapActivateNode = 'l'
let g:NERDTreeMapOpenRecursively = 'L'
let g:NERDTreeMapCloseDir = 'h'
" 显示隐藏文件
let g:NERDTreeMapToggleHidden = '.'
" 回到上一级目录
let g:NERDTreeMapUpdirKeepOpen = '<backspace>'
" 在新的tab打开
let g:NERDTreeMapOpenInTab = 't'
" 在节点之间跳转，无效
let g:NERDTreeMapJumpNextSibling = 'J'
let g:NERDTreeMapJumpPrevSibling = 'K'

"-----------------------------------------------------------------------------
" 快捷键
"-----------------------------------------------------------------------------

" map <leader>nn :NERDTreeToggle<cr>
map <silent> <leader>nn :call NERDOpen(':NERDTreeToggle')<cr>
" show path of current file
map <silent> <leader>nf :call NERDOpen(':NERDTreeFind')<cr>
" map <leader>nb :NERDTreeFromBookmark<Space>

"-----------------------------------------------------------------------------
" 一些函数
"-----------------------------------------------------------------------------
function! NERDOpen(cmd) abort
    if (winnr('$') == 1 && exists("b:NERDTree"))
        return
    else
        exe a:cmd
    endif
endfunction

function! s:NERDTreeCustomCROpen(node) abort
    let l:newRoot = a:node.GetSelected()

    if l:newRoot.path.isDirectory
        call b:NERDTree.changeRoot(l:newRoot)
    else
        call l:newRoot.activate({'reuse': 'all', 'where': 'p'})
    endif
endfunction

function! NERDTreeYankCurrentNode(node)
    " let n = g:NERDTreeFileNode.GetSelected()
    let l:s = a:node.GetSelected()
    if l:s != {}
        call setreg('"', l:s.path.str())
    endif
endfunction

" 只有一个窗口和nerdtree的时候，退出窗口即退出vim而不保留nerdtree
" autocmd BUFENTER * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


augroup vime_nerdtree_group
    autocmd!
    " 只有一个窗口和nerdtree的时候，退出窗口即退出vim而不保留nerdtree
    autocmd BUFENTER * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    autocmd FileType nerdtree nmap <buffer> <CR> bb

    " 自定义打开目录操作
    " TODO 如何直接定义<CR>作为快捷键?
    autocmd VimEnter * call NERDTreeAddKeyMap({
        \ 'key': 'bb',
        \ 'callback': function('<SID>NERDTreeCustomCROpen'),
        \ 'quickhelpText': 'go to dir and change cwd to it or open a file',
        \ 'scope': 'Node',
        \ 'override': 1,
        \ })
"
    " 复制路径
    autocmd VimEnter * call NERDTreeAddKeyMap({
            \ 'key': 'yp',
            \ 'callback': 'NERDTreeYankCurrentNode',
            \ 'quickhelpText': 'put full path of current node into the default register',
            \ 'scope': 'Node',
            \ 'override': 1,
            \ })
augroup END
