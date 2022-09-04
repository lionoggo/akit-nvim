""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 首次使用自动加载插件管理器
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.nvim_runtime/autoload/plug.vim'))
    silent !curl -fLo ~/.nvim_runtime/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 根据环境加载插件
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin(get(g:, 'plugins_install_path', '~/.vim/plugin/'))

LoadScript plugin_group/git.vim

LoadScript plugin_group/lsp_coc.vim

LoadScript plugin_group/plugin_list.vim
call plug#end()
