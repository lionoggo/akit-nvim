set updatetime=100

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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" tab触发补全或者选择下一个补全
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" shift tab 选择上一个补全
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" 使用ctrl space触发补全(和输入法快捷键冲突,可将输入法切换快捷键设置为cmd+space)
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" 定义跳转
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
" 重构refactor,需要lsp支持
nmap <silent> <space>rf <Plug>(coc-refactor)
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" 悬浮显示定义
nnoremap <silent> <space>k :call CocActionAsync('showSignatureHelp')<CR>
" 函数参数的文档
nnoremap <silent> <space>k :call CocActionAsync('showSignatureHelp')<CR>

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Highlight symbol under cursor on CursorHold
au CursorHold * silent call CocActionAsync('highlight')
" au CursorHoldI * sil call CocActionAsync('showSignatureHelp')
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
