" let g:gitgutter_override_sign_column_highlight = 0
highlight GitGutterAdd        guifg=#009900     ctermfg=Green
highlight GitGutterChange     guifg=#bbbb00     ctermfg=Yellow
highlight GitGutterDelete     guifg=#ff2222     ctermfg=Red
" 跳转到下一个修改点
nmap ) <Plug>(GitGutterNextHunk)
" 跳转到上一个修改点
nmap ( <Plug>(GitGutterPrevHunk)
" 默认打开
let g:gitgutter_enabled = 1
" 禁用自带key map,使用自定义
let g:gitgutter_map_keys = 0


