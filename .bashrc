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

export PATH=~/bin:$PATH

export GOPATH=~/Projects/go

# Set history
export HISTSIZE=5000
export HISTFILE=~/.bash_history
export HISTTIMEFORMAT="%F %T "
export HISTCONTROL=ignoredups
export PROMPT_COMMAND="history -a" # Appends immediately to history

which brew >/dev/null && source $(brew --prefix)/etc/bash_completion

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
