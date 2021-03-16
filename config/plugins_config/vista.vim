" vista.vim
function! NearestMethodOrFunction() abort
      return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_executive_for = {
                  \ 'cpp': 'coc',
                  \ 'php': 'coc',
                  \ }
let g:vista_ctags_cmd = {
                  \ 'haskell': 'hasktags -x -o - -c',
                  \ }
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
                  \   "function": "\uf794",
                  \   "variable": "\uf71b",
                  \  }
nnoremap <silent><nowait> <leader>tt :<C-u>Vista!!<cr>

" clean up vista when main window exit
function! s:side_windows_only() abort
      let tab_info = gettabinfo(tabpagenr())[0]
      for win_id in tab_info['windows']
            if index(['vista'], getwinvar(win_id, '&filetype')) < 0
                  return v:false
            endif
      endfor
      return v:true
endfunction
autocmd BufEnter,WinEnter * if s:side_windows_only() | q | endif
