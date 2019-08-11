# .bash_profile, .zshenv

[[ -d /Applications/Xcode.app/Contents/Developer ]] && \
        export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer

HOMEBREW_PREFIX=/opt/homebrew
if [ -d ${HOMEBREW_PREFIX} ]; then
    [[ -d ${HOMEBREW_PREFIX}/bin ]] && export PATH=${HOMEBREW_PREFIX}/bin:${PATH}
    [[ -d ${HOMEBREW_PREFIX}/sbin ]] && export PATH=${HOMEBREW_PREFIX}/sbin:${PATH}

    [[ -d ${HOMEBREW_PREFIX}/cache ]] && export HOMEBREW_CACHE=${HOMEBREW_PREFIX}/cache
fi

if [ -n ${ZSH_VERSION} ]; then
    :
else
    [[ -f ${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh ]] && \
        . ${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh

    [[ -f ~/.bashrc ]] && . ~/.bashrc
fi

# User specific environment and startup programs
export HISTSIZE=65536
