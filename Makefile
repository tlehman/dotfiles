.PHONY: backup restore link unlink

backup:
	@if [ -d "$$HOME/.config" ]; then \
		mkdir -p "$$HOME/.config.bak"; \
		cp -r "$$HOME/.config" "$$HOME/.config.bak"; \
		echo "Backup created at $$HOME/.config.bak"; \
	else \
		echo "No ~/.config directory found"; \
	fi

restore:
	@if [ -d "$$HOME/.config.bak" ]; then \
		mv "$$HOME/.config.bak" "$$HOME/.config"; \
		echo "Restored config from backup"; \
	else \
		echo "No backup directory found at $$HOME/.config.bak"; \
	fi

link: link-config link-zshrc

link-config:
	@if [ -d "./config" ]; then \
		echo "Linking ./config to ~/.config"; \
		ln -snf "$(CURDIR)/config" "$(HOME)/.config"; \
	else \
		echo "Error: ./config directory not found"; \
		exit 1; \
	fi

link-zshrc:
	@if [ -f "./zshrc" ]; then \
		echo "Linking ./zshrc to ~/.zshrc"; \
		ln -snf "$(CURDIR)/zshrc" "$(HOME)/.zshrc"; \
	else \
		echo "Error: ./zshrc file not found"; \
		exit 1; \
	fi


unlink: unlink-config unlink-zshrc

unlink-config:
	@if [ -L "$(HOME)/.config" ]; then \
		echo "Removing ~/.config symlink"; \
		rm "$(HOME)/.config"; \
	elif [ -d "$(HOME)/.config" ]; then \
		echo "Warning: ~/.config exists but isn't a symlink (preserving)"; \
	else \
		echo "~/.config symlink doesn't exist"; \
	fi

unlink-zshrc:
	@if [ -L "$(HOME)/.zshrc" ]; then \
		echo "Removing ~/.zshrc symlink"; \
		rm "$(HOME)/.zshrc"; \
	elif [ -f "$(HOME)/.zshrc" ]; then \
		echo "Warning: ~/.zshrc exists but isn't a symlink (preserving)"; \
	else \
		echo "~/.zshrc symlink doesn't exist"; \
	fi
