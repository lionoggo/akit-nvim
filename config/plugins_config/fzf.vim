nnoremap <C-p> :GFiles<CR>
" map <C-f> :Files<CR>
map <leader>b :Buffers<CR>
nnoremap <leader>f :Rg<CR>
nnoremap <leader>m :Marks<CR>
" noremap <C-h> :History<CR>
" noremap <C-t> :BTags<CR>
" noremap <C-l> :Lines<CR>
" noremap <C-w> :Buffers<CR>
" noremap <leader>; :History:<CR>

let g:fzf_preview_window = 'right:60%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

noremap <c-d> :BD<CR>

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.7 } }
" 查找输入框在顶部
let $FZF_DEFAULT_OPTS='--reverse'
