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
echo "Installed the Ultimate Vim configuration successfuly! Enjoy : -)"
