"-----------------------------------------------------------------------------
" 全局配置
"-----------------------------------------------------------------------------

"-----------------------------------------------------------------------------
" 快捷键
"-----------------------------------------------------------------------------
nnoremap <leader>gc <esc> :Git commit<CR>
" 显示提交日志
nnoremap <leader>gl <esc>:Git log<cr>
" 显示当前git状态
nnoremap <leader>gg <esc>:Git<cr>
" nnoremap gb :Git blame<CR>
" nnoremap gs :Gstatus<CR>
nnoremap <leader>gp :Nrun git push<CR>

" 合并冲突的时候,在Gstatus下使用dd/dv进入水平/竖直分栏状态:gf用来应用左边修改;gh用来应用右边修改
" (以g为分割点,左边是f,右边是h)
nmap <leader>gh :diffget //3<CR>
nmap <leader>gl :diffget //2<CR>

" 在新的terminal中执行push操作,不阻塞当前操作
command! -complete=file -nargs=* Nrun :call s:Terminal(<q-args>)

function! s:Terminal(cmd)
    execute 'belowright 5new'
    set winfixheight
    call termopen(a:cmd,{
        \ 'on_exit': function('s:OnExit'),
        \ 'buffer_nr': bufnr('%'),
        \})
    call setbufvar('%','is_autorun',1)
    execute 'wincmd p'
endfunction

function! s:OnExit(job_id, status, event) dict
    if a:status == 0
        execute 'silent! bd! '.self.buffer_nr
    endif
endfunction

