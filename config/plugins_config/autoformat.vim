" Auto-Format
" -----------
" 需要安装相应的格式化工具
" js-beautiful:js, html, css, json
" astyle:c, c++, java,
" autopep8:python

" 可以选择一部分进行格式化
autocmd FileType vim,tex let b:autoformat_autoindent=0

" normap <F3> :Autoformat<CR>
nnoremap \f :Autoformat<CR>
let g:formatdef_scalafmt = "'scalafmt --stdin'"
let g:formatters_scala = ['scalafmt']
