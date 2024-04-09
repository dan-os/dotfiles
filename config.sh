#! /bin/bash

DOTFILES=(.gitconfig .gitignore .zshrc)

# Copy home files
for dotfile in $(echo ${DOTFILES[*]});
do
    cp ~/dotfiles/home/$(echo $dotfile) ~/$(echo $dotfile)
done
