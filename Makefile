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
	done;

	# Override files
	cp -rfT $(CURDIR) $(HOME)
