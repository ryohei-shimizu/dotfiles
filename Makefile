SRCS = .config/git .tigrc .tmux.conf .vim .vimrc .zshrc
TARGET = $(patsubst %,~/%,$(SRCS))
PACKAGES = fzf ghq rbenv tig tmux zsh-autosuggestions zsh-completions zsh-syntax-highlighting

~/%: %
	ln -s $(PWD)/$< $@

install: $(TARGET)

install_packages:
	curl -s https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh > ~/.git-completion.zsh
	curl -s https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh
	brew install $(PACKAGES)

clean:
	rm -f $(TARGET)

set_defaults:
	defaults delete com.apple.dock
	defaults write  com.apple.dock autohide             -boolean    true
	defaults write  com.apple.dock autohide-delay       -float      0.0
	defaults write  com.apple.dock ResetLaunchPad       -boolean    true
	defaults write  com.apple.dock size-immutable       -boolean    true
	defaults write  com.apple.dock position-immutable   -boolean    true
	defaults write  com.apple.dock orientation          -string     "bottom"
	defaults write  com.apple.finder CreateDesktop      -boolean    false
	defaults write  com.apple.screencapture disable-shadow -boolean true
	defaults write  com.apple.screencapture type jpeg
	killall Dock
