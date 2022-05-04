SHELL := bash

.PHONY: all
all: dotfiles

.PHONY: dotfiles
dotfiles:
	# Remove previous config for dotfiles managed directories
	for config_dir_src in $(shell find $(CURDIR)/.config/* -maxdepth 0 -type d); do \
		dir_name=$$(basename $$config_dir_src); \
		des_dir="$$HOME/.config/$$dir_name"; \
		mkdir -p $$des_dir; \
		rm -rf $$des_dir/*; \
		cp -rf $$config_dir_src/* $$des_dir; \
	done;

	# Apply root dotfiles
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".git" -not -name ".config"); do \
		f=$$(basename $$file); \
		echo $$f; \
	done;

	# Generate nvim packer compiled file 		
	nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
