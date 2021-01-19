#!/bin/sh

set -e

cd ~/.nvim_runtime

rename_if_file_exists(){
    local random="$RANDOM"
    if [[ -e "$HOME/.ideavimrc"  ]]; then
        echo "$(tput setaf 1)>>> "file \".ideavimrc\" has already exists which had been renamed to .ideavimrc-$random"  $(tput sgr0)"
        mv "$HOME/.ideavimrc" "$HOME/.ideavimrc-$random"
    fi
}

rename_if_file_exists

# rm -f "$HOME/.ideavimrc" 2>/dev/null
# ln -s "$PWD/config/idea/basic.vim" "$HOME/.ideavimrc"

rm -f "$HOME/.ideavimrc" 2>/dev/null
ln -s ~/.nvim_runtime/config/idea/basic.vim "$HOME/.ideavimrc"

# echo 'set runtimepath+=~/.nvim_runtime
# source  ~/.nvim_runtime/config/idea/basic.vim
# ' > ~/.ideavimrc

echo "Installed the basic Vim configuration for ideavim successfuly! Enjoy : -)"
