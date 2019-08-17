SRCS = .bash_profile .bashrc .gitconfig .inputrc .tigrc .tmux.conf .vim .vimrc .zshenv .zshrc
TARGET = $(patsubst %,~/%,$(SRCS))

~/%: %
	ln -s $(PWD)/$< $@

~/.zshenv: .bash_profile
	ln -s $(PWD)/$< $@

~/.zshrc: .bashrc
	ln -s $(PWD)/$< $@

install: $(TARGET)

clean:
	rm -f $(TARGET)
