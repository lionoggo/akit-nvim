" Auto-Format
" -----------
" normap <F3> :Autoformat<CR>
nnoremap \f :Autoformat<CR>
let g:formatdef_scalafmt = "'scalafmt --stdin'"
let g:formatters_scala = ['scalafmt']
