"-----------------------------------------------------------------------------
" 全局配置
"-----------------------------------------------------------------------------
" let g:undotree_DiffAutoOpen = 1
" let g:undotree_SetFocusWhenToggle = 1
" let g:undotree_ShortIndicators = 1
" let g:undotree_WindowLayout = 2
" let g:undotree_DiffpanelHeight = 8
" let g:undotree_SplitWidth = 24
if !exists('g:undotree_WindowLayout')
    let g:undotree_WindowLayout = 3
endif
"-----------------------------------------------------------------------------
" 快捷键
"-----------------------------------------------------------------------------
nnoremap <F6> :UndotreeToggle<cr>

"-----------------------------------------------------------------------------
" 一些函数
"-----------------------------------------------------------------------------
function g:Undotree_CustomMap()
	nmap <buffer> u <plug>UndotreeNextState
	nmap <buffer> e <plug>UndotreePreviousState
	nmap <buffer> U 5<plug>UndotreeNextState
	nmap <buffer> E 5<plug>UndotreePreviousState
endfunc
