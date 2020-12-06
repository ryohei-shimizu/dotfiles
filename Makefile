SRCS = .config/git .inputrc .tigrc .tmux.conf .vim .vimrc .zshrc
TARGET = $(patsubst %,~/%,$(SRCS))

~/%: %
	ln -s $(PWD)/$< $@

install: $(TARGET)

clean:
	rm -f $(TARGET)
