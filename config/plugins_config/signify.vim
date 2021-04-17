let g:signify_vcs_list = [ 'git', 'hg' ]

" nnoremap <leader> gd: SignifyDiff<cr>
" nnoremap <leader> gp：SignifyHunkDiff <cr>
" nnoremap <leader> gu：SignifyHunkUndo <cr>
nmap { <plug>(signify-next-hunk)
nmap } <plug>(signify-prev-hunk)

nnoremap <leader>sd: SignifyHunkDiff<cr>
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=none
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=none
highlight DiffChange        cterm=bold ctermbg=none ctermfg=none
highlight SignifySignAdd    cterm=bold ctermbg=none  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=none  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=none  ctermfg=227
