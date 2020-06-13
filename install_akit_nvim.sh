#!/bin/sh

set -e

cd ~/.nvim_runtime

if [[ ! -d ~/.config/nvim ]]; then
    echo 'neovim not installed in your system.'
    exit 1
fi
echo 'set runtimepath+=~/.nvim_runtime
source  ~/.nvim_runtime/nvim.vim
' > ~/.config/nvim/init.vim

coc_check(){
    if [[ -f ~/.config/nvim/coc-settings.json ]]; then
        local coc_diff=$(git diff ~/.nvim_runtime/coc-settings.json ~/.config/nvim/coc-settings.json)
        if [[ -n "$coc_diff" ]]; then
            echo -e "\033[31mcoc-settings.json conflict:  \033[0m"
            echo "$coc_diff"
        fi
    else
        [ -L ~/.config/nvim/coc-settings.json ] && rm -f ~/.config/nvim/coc-settings.json
        ln -s ~/.nvim_runtime/coc-settings.json ~/.config/nvim/coc-settings.json
    fi
}
coc_check
echo "Installed the Ultimate Vim configuration successfuly! Enjoy : -)"
