# .bashrc

export PATH=/opt/homebrew/bin:${PATH}
export HOMEBREW_CACHE=/opt/homebrew/cache

stty stop undef

if [ -r ~/.git-prompt.sh ]; then
    . ~/.git-prompt.sh
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWUPSTREAM="verbose"
    PS1='\e[32m\h\e[m:\e[34m\w\e[m$(__git_ps1 " \e[31m(%s)\e[m")\n\u\$ '
else
    PS1='\e[32m\h\e[m:\e[34m\w\e[m\n\u\$ '
fi

[[ -r ~/.git-completion.bash ]] && . ~/.git-completion.bash
