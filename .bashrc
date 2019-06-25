# .bashrc

stty stop undef

[[ ! -r ~/.git-completion.bash ]] && curl -s \
        https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash
[[ ! -r ~/.git-prompt.sh ]] && curl -s \
        https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh

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
