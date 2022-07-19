# .zshrc

function configure_zsh() {
    [[ -z ${ZSH_VERSION} ]] && return

    HISTSIZE=100000
    SAVEHIST=100000

    # History
    # setopt APPEND_HISTORY <D>
    setopt BANG_HIST #(+K) <C> <Z>
    # setopt EXTENDED_HISTORY <C>
    # setopt HIST_ALLOW_CLOBBER
    # setopt HIST_BEEP <D>
    # setopt HIST_EXPIRE_DUPS_FIRST
    # setopt HIST_FCNTL_LOCK
    # setopt HIST_FIND_NO_DUPS
    # setopt HIST_IGNORE_ALL_DUPS
    # setopt HIST_IGNORE_DUPS (-h)
    # setopt HIST_IGNORE_SPACE (-g)
    # setopt HIST_LEX_WORDS
    # setopt HIST_NO_FUNCTIONS
    # setopt HIST_NO_STORE
    setopt HIST_REDUCE_BLANKS
    # setopt HIST_SAVE_BY_COPY <D>
    setopt HIST_SAVE_NO_DUPS
    # setopt HIST_VERIFY
    # setopt INC_APPEND_HISTORY
    # setopt INC_APPEND_HISTORY_TIME
    # setopt SHARE_HISTORY <K>

    # Prompting
    setopt PROMPT_SUBST

    setopt nonomatch

    setopt hist_expand

    bindkey -v

    autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
    zle -N up-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey "^[[A" up-line-or-beginning-search
    bindkey "^[[B" down-line-or-beginning-search

    if [ -e /opt/homebrew ]; then

        # zsh-completions
        FPATH=/opt/homebrew/share/zsh-completions:$FPATH
        autoload -Uz compinit
        compinit

        # zsh-autosuggestions
        source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

        # zsh-syntax-highlighting
        source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

        # fzf
        source ~/.fzf.zsh
    fi
}

function lg() {
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
        cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
        rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

stty stop undef # Undefine <C-s>

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias ll='ls -lF'
alias ls='ls -F'
alias chgrp='chgrp -v'
alias chmod='chmod -v'
alias chown='chown -v'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias pgrep='pgrep -fl'

alias c='clear'
alias g='git'

alias mk='make'
alias mkc='make clean'
alias mkj='make -j `nproc`'

alias t='tig'
alias ta='tig --all'

alias symbolicatecrash='/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash'

configure_zsh
PS1=$'\n%U%~%u\n%n\$ '

if [ -r ~/.git-prompt.sh ]; then
    . ~/.git-prompt.sh
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWUPSTREAM="verbose"

    if [ -n ${ZSH_VERSION} ]; then
        PS1=$'\n%U%~%u $(__git_ps1 "ᚠ %s")\n%n\$ '
    else
        PS1='\e[32m\h\e[m:\e[34m\w\e[m$(__git_ps1 " \e[31m(%s)\e[m")\n\u\$ '
    fi
fi

export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jre/Contents/Home

# export PATH for Homebrew
export PATH=/opt/homebrew/bin:$PATH

[[ -d $HOME/Library/Android/sdk/platform-tools ]] && export PATH=${PATH}:${HOME}/Library/Android/sdk/platform-tools

if [ -e $HOME/.nodebrew ]; then
    export PATH=$HOME/.nodebrew/current/bin:$PATH
fi

if [ -e ~/.rbenv ]; then
    eval "$(rbenv init -)"
fi

if [ -z $TMUX ] && [ $TERM_PROGRAM = "Apple_Terminal" ]; then tmux attach || tmux -u; fi
