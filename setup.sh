#!/bin/bash

git_dir=$1
home=$2

ln -sf $git_dir/.bashrc $home/.bashrc
ln -sf $git_dir/.tmux.conf $home/.tmux.conf
ln -sf $git_dir/.vimrc $home/.vimrc
ln -sf $git_dir/.vim $home/.vim
 
