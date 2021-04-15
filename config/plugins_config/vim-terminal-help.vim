" 需要注意如果是在iterm2中使用alt需要首先在对应的profiles中设置Keys为Esc+
" 首先使用command+o打开profiles面板,然后点击Edit Profiles按钮,点击下方的
" 选项卡Keys,然后将下方more的Normal修改为Keys
" ALT + =: toggle terminal below.
" ALT + SHIFT + h: move to the window on the left.
" ALT + SHIFT + l: move to the window on the right.
" ALT + SHIFT + j: move to the window below.
" ALT + SHIFT + k: move to the window above.
" ALT + -: paste register 0 to terminal
let g:terminal_height=10
"let g:terminal_shell =
" let g:terminal_edit='window drop'
let g:terminal_list=0 "set to 0 to hide terminal buffer in the buffer list.
" let g:terminal_cwd=1 " initialize working dir: 0 for unchanged, 1 for file path and 2 for project root.
" let g:terminal_default_mapping=1
