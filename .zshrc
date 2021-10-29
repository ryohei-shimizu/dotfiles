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

    if type brew &>/dev/null; then
        HB_PREFIX=$(brew --prefix)

        # zsh-completions
        FPATH=${HB_PREFIX}/share/zsh-completions:$FPATH
        autoload -Uz compinit
        compinit

        # zsh-autosuggestions
        source ${HB_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh

        # zsh-syntax-highlighting
        source ${HB_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

        # fzf
        source ~/.fzf.zsh

        unset HB_PREFIX
    fi
}

function postinstall_darwin() {
        local pkgs=( \
                "git" \
                "rbenv" \
                "tig" \
                "tmux" \
                "zsh-autosuggestions" \
                "zsh-completions" \
                "zsh-syntax-highlighting" \
                )
        for pkg in ${pkgs[@]}; do
            brew install ${pkg}
        done

        defaults delete com.apple.dock
        defaults write  com.apple.dock autohide       -bool true
        # defaults write  com.apple.dock autohide-delay -float 0
        defaults write  com.apple.dock ResetLaunchPad       -boolean    true
        defaults write  com.apple.dock size-immutable       -boolean    true
        defaults write  com.apple.dock position-immutable   -boolean    true
        defaults write  com.apple.dock orientation          -string     "bottom"

        defaults write  com.apple.finder CreateDesktop      -boolean    false

        # Hot corners
        #  0: -                      2: Mission Control
        #  3: Application Windows    4: Desktop
        #  5: Start Screen Saver     6: Disable Screen Saver
        #  7: Dashboard             10: Put Display to Sleep
        # 11: Launchpad             12: Notification Center

        # Top left screen corner
        defaults write com.apple.dock wvous-tl-corner -int 0
        defaults write com.apple.dock wvous-tl-modifier -int 0
        # Top right screen corner
        defaults write com.apple.dock wvous-tr-corner -int 0
        defaults write com.apple.dock wvous-tr-modifier -int 0
        # Bottom left screen corner
        defaults write com.apple.dock wvous-bl-corner -int 0
        defaults write com.apple.dock wvous-bl-modifier -int 0
        # Bottom right screen corner
        defaults write com.apple.dock wvous-br-corner -int 0
        defaults write com.apple.dock wvous-br-modifier -int 0

        killall Dock
}

function postinstall() {
    case $(uname) in
        Darwin)
        postinstall_darwin ;;
    esac

    [[ ! -r ~/.git-completion.zsh ]] && curl -s \
        https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh > ~/.git-completion.zsh
    [[ ! -r ~/.git-prompt.sh ]] && curl -s \
        https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh
}

function print_colors() {
    local fg="\x1b[38;5;"
    local bg="\x1b[48;5;"
    local rs="\x1b[0m"
    local color=0
    local row
    local col

    for row in `seq 0 1`; do
        for col in 0 1 2 3 4 5 6 7; do
            printf "${bg}${color}m %03d ${rs}${fg}${color}m %03d ${rs}" $color $color
            color=$((color + 1))
        done
        printf "\n"
    done
    for row in `seq 0 39`; do
        for col in 0 1 2 3 4 5; do
            printf "${bg}${color}m %03d ${rs}${fg}${color}m %03d ${rs}" $color $color
            color=$((color + 1))
        done
        printf "\n"
    done
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

HOMEBREW_PREFIX=/usr/local

[[ -d $HOME/Library/Android/sdk/platform-tools ]] && export PATH=${PATH}:${HOME}/Library/Android/sdk/platform-tools
[[ -d ${HOMEBREW_PREFIX}/sbin ]] && export PATH=${HOMEBREW_PREFIX}/sbin:${PATH}
[[ -d ${HOMEBREW_PREFIX}/bin ]] && export PATH=${HOMEBREW_PREFIX}/bin:${PATH}
[[ -d ${HOMEBREW_PREFIX}/cache ]] && export HOMEBREW_CACHE=${HOMEBREW_PREFIX}/cache

export PATH=$HOME/.nodebrew/current/bin:$PATH

if [ -e ~/.rbenv ]; then
    eval "$(rbenv init -)"
fi

# if [ -z $TMUX ] && [ $SHLVL -eq 1 ]; then tmux attach || tmux -u; fi
