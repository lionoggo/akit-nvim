let g:ale_linters = {
                  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
                  \   'asm': ['gcc'],
                  \   'nasm': ['nasm'],
                  \   'c': ['cppcheck', 'clang'],
                  \   'cpp': ['cppcheck', 'clang'],
                  \   'cmake': ['cmake-format'],
                  \   'python': ['pylint', 'flake8'],
                  \   'cuda': ['nvcc'],
                  \   'go': ['gofmt'],
                  \   'java': ['javac'],
                  \   'javascript': ['eslint'],
                  \   'shell': ['shell -n flag'],
                  \   'zsh': ['shell'],
                  \   'lua': ['luac'],
                  \   'yaml': ['prettier'],
                  \   'latex': ['alex'],
                  \   'vue': ['eslint'],
                  \ }
" 始终开启标志列
let g:ale_sign_column_always = 1
" only run linters named in ale_linters seetings
let g:ale_linters_explicit = 1
let g:ale_set_highlights = 0

" 高亮显示错误的地方
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_echo_msg_format = '[%severity% %linter%] -> %s'

"ccls
let g:ale_cpp_ccls_init_options = {
                  \   'cache': {
                  \       'directory': '/tmp/ccls/cache',
                  \   },
                  \ }
let g:ale_completion_enabled = 1
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign
" 快捷键
nmap gd :ALEGoToDefinition<cr>
nmap gr :ALEFindReferences<cr>

nmap K :ALEHover<cr>

" only display sign, hide it's background(when we use gruvbox themes)
" link: https://github.com/dense-analysis/ale/issues/349
" highlight ALEErrorSign guibg=yellow guifg=red ctermbg=NONE ctermfg=red
" highlight ALEInfoSign guibg=214 guifg=orange  ctermfg=214 ctermbg=NONE
highlight ALEInfoSign ctermfg=109 ctermbg=NONE guifg=#83a598 guibg=#3c3836
highlight ALEErrorSign ctermfg=167 ctermbg=NONE guifg=#fb4934 guibg=#3c3836
highlight ALEWarningSign ctermfg=214 ctermbg=NONE guifg=#fabd2f guibg=#3c3836
