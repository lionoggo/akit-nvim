
let g:coc_global_extensions =
            \ [
            \ 'coc-python',
            \ 'coc-tsserver',
            \ 'coc-java',
            \ 'coc-vimtex',
            \ 'coc-html',
            \ 'coc-css',
            \ 'coc-yaml',
            \ 'coc-json',
            \ 'coc-emmet',
            \ 'coc-snippets',
            \ 'coc-emoji',
            \ 'coc-highlight',
            \ 'coc-git',
            \ 'coc-sh',
            \ 'coc-explorer',
            \ ]
            " \ 'coc-ccls',
            " \ 'coc-java',
            """""""
            " \ 'coc-diagnostic',
            " \ 'coc-prettier',
            " \ 'coc-pairs',
						"
" 回车完成代码块
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
                                           \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use <Tab> navigate the completion list
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" 使用ctrl space触发补全(和输入法快捷键冲突)
" inoremap <silent><expr> <c-space> coc#refresh()`

" 定义跳转
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" 定义打开文件浏览
nmap tt :CocCommand explorer<CR>

" Use K to show documentation in preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

nnoremap <silent> <space>k :call CocActionAsync('showSignatureHelp')<CR>

" Remap for rename current word
nmap <space>rn <Plug>(coc-rename)

" Highlight symbol under cursor on CursorHold
set updatetime=100
au CursorHold * silent call CocActionAsync('highlight')
au CursorHoldI * sil call CocActionAsync('showSignatureHelp')
