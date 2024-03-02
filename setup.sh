#!/bin/bash

ln -sfn ~/Dotfiles/.bashrc ~/.bashrc
source ~/.bashrc
mkdir -p $XDG_CONFIG_HOME
ln -sfn ~/Dotfiles/.inputrc ~/.inputrc
ln -sfn ~/Dotfiles/.vimrc ~/.vimrc
ln -sfn ~/Dotfiles/.vim ~/.vim
ln -sfn ~/Dotfiles/tmux $XDG_CONFIG_HOME/tmux
ln -sfn ~/Dotfiles/git $XDG_CONFIG_HOME/git
ln -sfn ~/Dotfiles/alacritty $XDG_CONFIG_HOME/alacritty
ln -sfn ~/Dotfiles/.minttyrc ~/.minttyrc
ln -sfn ~/Dotfiles/.i3 ~/.i3
ln -sfn ~/Dotfiles/.Xresources ~/.Xresources
mkdir -p ~/.emacs.d
ln -sfn ~/Dotfiles/init.el ~/.emacs.d/init.el
mkdir -p ~/.config/qtile
ln -sfn ~/Dotfiles/qtile/config.py ~/.config/qtile/config.py
ln -sfn ~/Dotfiles/qtile/autostart.sh ~/.config/qtile/autostart.sh
mkdir -p ~/.config/pipewire/pipewire.conf.d
ln -sfn ~/Dotfiles/10-virtual-mic.conf ~/.config/pipewire/pipewire.conf.d/10-virtual-mic.conf
