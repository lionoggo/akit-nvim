function! s:patch_lucius_colors()
    if has('termguicolors')
        set termguicolors
    endif
    " hi Normal     ctermbg=NONE guibg=NONE
    hi LineNr     ctermbg=NONE guibg=NONE
    hi SignColumn ctermbg=NONE guibg=NONE
    " set background=light

endfunction

autocmd! colorscheme gruvbox call s:patch_lucius_colors()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 颜色主题
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
set t_Co=256
try
    colorscheme gruvbox1
    " colorscheme molokai
catch
endtry
" 更清晰的错误标注：默认一片红色背景，语法高亮都被搞没了
" 只显示红色或者蓝色下划线或者波浪线
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! clear SpellLocal
if has('gui_running')
    hi! SpellBad gui=undercurl guisp=red
    hi! SpellCap gui=undercurl guisp=blue
    hi! SpellRare gui=undercurl guisp=magenta
    hi! SpellRare gui=undercurl guisp=cyan
else
    hi! SpellBad term=standout ctermfg=1 term=underline cterm=underline
    hi! SpellCap term=underline cterm=underline
    hi! SpellRare term=underline cterm=underline
    hi! SpellLocal term=underline cterm=underline
endif

" 去掉sign column 的白色背景
hi! SignColumn guibg=NONE ctermbg=NONE

" 修改行号为浅灰色,默认主题的黄色行号很难看,换主题可以仿照修改
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE
            \ gui=NONE guifg=DarkGrey guibg=NONE

" 修正补全目录(悬浮提示)的色彩：默认太难看
" hi! Pmenu guibg=gray guifg=black ctermbg=gray ctermfg=black
" hi! PmenuSel guibg=gray guifg=brown ctermbg=brown ctermfg=gray
