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

echo 'set runtimepath+=~/.nvim_runtime
source  ~/.nvim_runtime/idea.vim
' > ~/.ideavimrc

echo "Installed the basic Vim configuration for ideavim successfuly! Enjoy : -)"
