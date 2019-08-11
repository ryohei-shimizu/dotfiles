# .bashrc, .zshrc

function configure_bash() {
    [[ -z ${BASH_VERSION} ]] && return
}

function configure_zsh() {
    [[ -z ${ZSH_VERSION} ]] && return
}

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

if [ -n ${ZSH_VERSION} ]; then
    :
else
    [[ -r ~/.git-completion.bash ]] && . ~/.git-completion.bash
fi

function postinstall() {
    if [ $(uname) == 'Darwin' ]; then
        local pkgs=( \
                "bash-completion@2" \
                "tig" \
                "tmux" \
                )
        for pkg in ${pkgs[@]}; do
            brew install ${pkg}
        done

        defaults delete com.apple.dock
        defaults write  com.apple.dock autohide       -bool true
        defaults write  com.apple.dock autohide-delay -float 0
        defaults write  com.apple.dock ResetLaunchPad -bool true

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
        defaults write com.apple.dock wvous-tr-corner -int 12
        defaults write com.apple.dock wvous-tr-modifier -int 0
        # Bottom left screen corner
        defaults write com.apple.dock wvous-bl-corner -int 11
        defaults write com.apple.dock wvous-bl-modifier -int 0
        # Bottom right screen corner
        defaults write com.apple.dock wvous-br-corner -int 0
        defaults write com.apple.dock wvous-br-modifier -int 0

        killall Dock
    fi

    [[ ! -r ~/.git-completion.bash ]] && curl -s \
        https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash
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
