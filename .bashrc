# Ghislain's .bashrc

export XDG_CONFIG_HOME="${HOME}/.config"

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

export PATH=~/.local/bin:~/.cargo/bin:~/bin:/usr/local/bin:$PATH

export GOPATH=~/projects/go

# Set history
export HISTSIZE=5000
export HISTFILE=~/.bash_history
export HISTTIMEFORMAT="%F %T "
export HISTCONTROL=ignoredups
export PROMPT_COMMAND="history -a" # Appends immediately to history

if [[ x$TERM = xdumb ]] ; then
    export PS1="\W $"
else
    green="\001$(tput setaf 2)\002"
    blue="\001$(tput setaf 4)\002"
    reset="\001$(tput sgr0)\002"
    export PS1="${reset}${green}\w\n${blue}\$ ${reset}"
fi

alias vi='vim'
alias ls='ls --color'
alias fixwrap='kill -WINCH $$'
alias bashref='links /usr/share/doc/bash/html/bashref.html'

export EDITOR=vim

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

if [ -e ~/.local_bashrc ]
then
    source ~/.local_bashrc
fi

eval "$(starship init bash)"
