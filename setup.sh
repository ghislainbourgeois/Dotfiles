#!/bin/bash

ln -sf ~/Dotfiles/.bashrc ~/.bashrc
ln -sf ~/Dotfiles/.inputrc ~/.inputrc
ln -sf ~/Dotfiles/.vimrc ~/.vimrc
ln -sf ~/Dotfiles/.vim ~/.vim
ln -sf ~/Dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/Dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/Dotfiles/.minttyrc ~/.minttyrc
ln -sf ~/Dotfiles/.i3 ~/.i3
ln -sf ~/Dotfiles/.Xresources ~/.Xresources
mkdir -p ~/.emacs.d
ln -sf ~/Dotfiles/init.el ~/.emacs.d/init.el 
mkdir -p ~/.config/qtile
ln -sf ~/Dotfiles/qtile/config.py ~/.config/qtile/config.py
ln -sf ~/Dotfiles/qtile/autostart.sh ~/.config/qtile/autostart.sh
