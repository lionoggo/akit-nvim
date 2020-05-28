nnoremap gca :Gcommit -a -v<CR>
nnoremap gb :Gblame<CR>
nnoremap ga :Gstatus<CR>
nnoremap gp :Nrun git push<CR>
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

