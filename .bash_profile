# .bash_profile

[[ ! -r ~/.git-prompt.sh ]] && curl -s \
        https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh
[[ ! -r ~/.git-completion.bash ]] && curl -s \
        https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash

[[ -r /opt/homebrew/etc/profile.d/bash_completion.sh ]] && . /opt/homebrew/etc/profile.d/bash_completion.sh

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs
export HISTSIZE=65536
