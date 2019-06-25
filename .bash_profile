# .bash_profile

[[ -d /Applications/Xcode.app/Contents/Developer ]] && \
        export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer

HOMEBREW_PREFIX=/opt/homebrew
if [ -d ${HOMEBREW_PREFIX} ]; then
    [[ -f ${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh ]] && \
        . ${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs
export HISTSIZE=65536
