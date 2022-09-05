"-----------------------------------------------------------------------------
" 全局配置
"-----------------------------------------------------------------------------
if exists('g:loaded_config_fzf_vim_vim')
    finish
endif
let g:loaded_config_fzf_vim_vim = 1

" fzf文件夹
let g:fzf_dir = g:cache_root_path . '/fzf'
" fzf history 文件
let g:fzf_history_dir = g:fzf_dir . "/fzf-history"

" 如果存在buffer，那么跳转过去
let g:fzf_buffers_jump = 1
"-----------------------------------------------------------------------------
" UI配置
"-----------------------------------------------------------------------------
" 查找输入框在顶部
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND = "rg --files --hidden"
" 预览窗口
" let g:fzf_preview_window = 'right:60%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" fzf外观
" coc-fzf也使用这个变量
let g:fzf_layout = {
    \ 'window': {
        \ 'up': '~90%', 'width': 0.6, 'height': 0.8, 'yoffset':0.5,
        \ 'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp'
    \ }
\ }

" 预览窗口配置
let s:preview_window_config = 'up:50%:wrap'
let s:preview_window = '--preview-window=' . s:preview_window_config
let g:fzf_preview_window = s:preview_window_config
" 自定义窗口预览程序
let s:preview_program = g:scripts_root_path . "/preview.sh"

" 配色与主题同色
" fg表示未选中行的前景色
" hl表示搜索到的文字的颜色
" fg+表示选中的行的前景色
" hl+表示选中的行的搜索文字颜色
let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Directory'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'WarningMsg'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

"-----------------------------------------------------------------------------
" Shortcut配置
"-----------------------------------------------------------------------------

" 使用ctrl jk上下移动选项
augroup akit_fzf_group
    autocmd!
    au FileType fzf tnoremap <buffer> <C-j> <Down>
    au FileType fzf tnoremap <buffer> <C-k> <Up>
    au FileType fzf tnoremap <buffer> <Esc> <c-g>
augroup END

nnoremap <silent> <leader><leader> :call FZFOpen(':Rg')<CR>
" FZF Search for Files
nnoremap <silent> <leader>f :call FZFOpen(":Files")<CR>

" " FZF in Open buffers
" nnoremap <silent> <leader><leader> :call FZFOpen(":Buffers")<CR>
"
"
" " FZF Search for Files in home dir
" nnoremap <silent> <leader>~ :call FZFOpen(":Files ~")<CR>
"
" " FZF Search for previous opened Files
" nnoremap <silent> <leader>zh :call FZFOpen(":History")<CR>
" map <C-f> :Files<CR>
" map <leader>b :Buffers<CR>
" nnoremap <leader>f :Rg<CR>
" nnoremap <leader>m :Marks<CR>
" noremap <C-h> :History<CR>
" noremap <C-t> :BTags<CR>
" noremap <C-l> :Lines<CR>
" noremap <C-w> :Buffers<CR>
" noremap <leader>; :History:<CR>
" nnoremap <C-p> :GFiles<CR>

"-----------------------------------------------------------------------------
" 一些函数
"-----------------------------------------------------------------------------
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

" Function to prevent FZF commands from opening in functional buffers
"
" See: https://github.com/junegunn/fzf/issues/453
" TODO: Remove once this workaround is no longer necessary.
function! FZFOpen(cmd)
    " Define the functional buffer types that we want to not clobber
    let functional_buf_types = ['quickfix', 'help', 'nofile', 'terminal']

    " If more than 1 window, and buffer type is not one of the functional types
    if winnr('$') > 1 && (index(functional_buf_types, &bt) >= 0)
        " Find all 'normal' (not functional) buffer windows
        let norm_wins = filter(range(1, winnr('$')),
                    \ 'index(functional_buf_types, getbufvar(winbufnr(v:val), "&bt")) == -1')

        " Grab the first one that we can use
        let norm_win = !empty(norm_wins) ? norm_wins[0] : 0

        " Move to that window
        exe norm_win . 'winc w'
    endif
    " Execute the passed command
    exe a:cmd
endfunction

