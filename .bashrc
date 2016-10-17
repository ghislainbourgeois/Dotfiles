# Ghislain's .bashrc

# Set shell options
if [[ ${BASH_VERSION%%.*} -ge 2 ]]; then
    shopt -s cdspell
    shopt -s checkwinsize
    shopt -s extglob
    if [[ ${BASH_VERSION%%.*} -ge 3 ]]; then
        shopt -s extquote
        if [[ ${BASH_VERSION%%.*} -ge 4 ]]; then
            shopt -s checkjobs
            shopt -s dirspell
        fi
    fi
fi

if [ -e /opt/vim8/bin/vim ]
then
    export PATH=/home/ghibourg/bin:$PATH
fi

export CDPATH=".:~:~/Projects"

# Set history
export HISTSIZE=5000
export HISTFILE=~/.bash_history
export HISTTIMEFORMAT="%F %T "
export HISTCONTROL=ignoredups
export PROMPT_COMMAND="history -a" # Appends immediately to history

if [[ x$TERM = xdumb ]] ; then
export PS1="\W $"
else
if [[ ${EUID} == 0 ]] ; then
export PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
else
export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
fi
fi

alias vi='vim'
alias ls='ls --color'
alias fixwrap='kill -WINCH $$'
alias bashref='links /usr/share/doc/bash/html/bashref.html'

export EDITOR=vim

if [ -e ~/.local_bashrc ]
then
source ~/.local_bashrc
fi

function su() {
if [ $# -eq 0 ]
then
`which su` root -c "bash --rcfile ${HOME}/.bashrc"
else
`which su` "$@"
fi
}

function send_key() {
cat ~/.ssh/id_rsa.pub | ssh $1 'mkdir -p ~/.ssh; cat - >> ~/.ssh/authorized_keys; chmod 700 ~/.ssh; chmod 600 ~/.ssh/authorized_keys'
}

function send_dotfiles() {
    scp ~/.bashrc $1:~/.bashrc
    scp ~/.vimrc $1:~/.vimrc
    scp ~/.screenrc $1:~/.screenrc
    scp ~/.tmux.conf $1:~/.tmux.conf
    scp ~/.ssh/config $1:~/.ssh/config
}
