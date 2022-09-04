" For startify
let g:startify_padding_left = 10
let g:startify_custom_header = [
\'',
\'                             ___   _   __ _____  _____       ',
\'                            / _ \ | | / /|_   _||_   _|      ',
\'                           / /_\ \| |/ /   | |    | |        ',
\'                           |  _  ||    \   | |    | |        ',
\'                           | | | || |\  \ _| |_   | |        ',
\'                           \_| |_/\_| \_/ \___/   \_/        ',
\'',
\]


let g:startify_files_number = 6
let g:startify_dir_number = 6
" session
let g:startify_session_dir = g:session_dir
" 自动保存，注意，只会自动保存载入的session
let g:startify_session_persistence = 1
" 保存session之前自动执行命令
let g:startify_session_before_save = [
    \ 'echo "Cleaning up before saving.."',
    \ 'silent! NERDTreeTabsClose'
    \ ]
"
" bookmarks 书签
" let g:startify_bookmarks = [
"             \ g:vimwiki_path . '/草稿/todo.md',
"             \ g:vimwiki_path . '/草稿/快速笔记.md',
"             \ g:quicknote_file
"             \ ]

" command 命令
let g:startify_commands = [
    \ {'u': ['Update Plugin', 'PlugUpdate']},
    \ {'t': ['Open Termimal', 'terminal']},
    \ {'w': ['Vim Wiki', 'VimwikiIndex']},
    \ {'s': ['Vim Startup', 'StartupTime']},
    \ ]

let g:startify_lists = [
       \ { 'type': 'sessions',  'header': ['        Sessions']       },
       \ { 'type': 'bookmarks', 'header': ['        Bookmarks']      },
       \ { 'type': 'files',     'header': ['        MRU']            },
       \ { 'type': 'dir',       'header': ['        MRU '. getcwd()] },
       \ { 'type': 'commands',  'header': ['        Commands']       },
       \ ]

noremap <leader>e <esc>:Startify<cr>
