function! common#common#init(rootPath) abort
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => 环境判断
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " 判断系统类型
    if(has('win32') || has('win64'))
        let g:isWIN = 1
        let g:isMAC = 0
    else
        if system('uname') =~ 'Darwin'
            let g:isWIN = 0
            let g:isMAC = 1
        else
            let g:isWIN = 0
            let g:isMAC = 0
        endif
    endif

    " 判断是是否处于GUI界面
    if has('gui_running')
        let g:isGUI = 1
    else
        let g:isGUI = 0
    endif
    " vimrc所在根目录
    let g:vim_root_path =a:rootPath
    " 配置所在根目录
    let g:config_root_path = g:vim_root_path.'/config/'
    " 插件配置所在目录
    let g:plugins_config_root_path = g:config_root_path . "plugins_config/"
    " 有些插件有额外的配置
    let g:other_config_root_path = g:config_root_path . "other/"

    " vim插件、缓存等数据根目录
    let g:cache_root_path = $HOME . '/.cache/vim/'
    " vim 插件安装目录
    let g:plugins_install_path = g:cache_root_path . 'plugins/'
    " session 保存目录
    let g:session_dir = g:cache_root_path . 'sessions/'
    " 撤销记录目录
    let g:undo_dir = g:cache_root_path . 'undo/'
    let g:tags=g:cache_root_path . 'tags/'

    let g:os = systemlist('uname -s')[0]
    let g:arch = systemlist('uname -m')[0]

    " tmux配置文件目录
    let g:tmux_config_path = $HOME . '/.tmux.conf'

    " 脚本目录
    let g:scripts_root_path = g:vim_root_path . "/scripts/"
    " wiki笔记根目录
    let g:vimwiki_path = $HOME . '/Documents/wiki/'

    " 快速note文件
    let g:quicknote_file = g:vimwiki_path . '/quicknote.md'
    let g:polyglot_disabled = []
    " wiki笔记根目录
    let g:vimwiki_path = $HOME . '/Documents/wiki/'
    " ale work with coc: The easiest way to get both plugins to work together is to configure coc.nvim to send diagnostics to ALE, so ALE controls how all problems are presented to you, and to disable all LSP features in ALE, so ALE doesn't try to provide LSP features already provided by coc.nvim, such as auto-completion.
    let g:ale_disable_lsp = 1
    let g:go_bin_path = $HOME."/go/bin"
    let g:molokai_original = 1
endfunction

