#!/bin/bash

config="$HOME/.config/nvim"
viminit="$config/init.vim"

[ ! -d "$config" ] && mkdir -p "$config"

if [ -f "$viminit" ]
then
    echo "File already exists: $viminit"
else
    echo "Creating $viminit"
    
    echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vim/vimrc" > "$viminit"
fi

echo "Done."
