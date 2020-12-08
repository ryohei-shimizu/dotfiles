SRCS = .config/git .config/karabiner/karabiner.json .inputrc .tigrc .tmux.conf .vim .vimrc .zshrc
TARGET = $(patsubst %,~/%,$(SRCS))

~/%: %
	ln -s $(PWD)/$< $@

install: $(TARGET)

clean:
	rm -f $(TARGET)
