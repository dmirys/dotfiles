#!/bin/bash

set -e

# Installation settings:
REPO_URL="git@github.com:dmirys/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"
BASH_CUSTOM="$HOME/.bash_custom"
BASHRC="$HOME/.bashrc"
BASHRC_SOURCE_LINE="source ~/.bash_custom"

if [ "$1" == "-u" ] || [ "$1" == "--uninstall" ]; then
	if grep -Fxq "$BASHRC_SOURCE_LINE" "$BASHRC"; then
		echo "--> Removing custom config source from .bashrc..."
		sed -i "\|$BASHRC_SOURCE_LINE|d" "$BASHRC"
	fi
    
	if [ -d "$DOTFILES_DIR" ]; then
		echo "--> Removing files tracked by dotfiles repository..."
		FILES=$(git -C "$HOME" --git-dir="$DOTFILES_DIR" ls-files)
		for file in $FILES; do
			echo "    $HOME/$file"
			rm -f "$HOME/$file"
		done

		echo "--> Removing dotfiles repository..."
		rm -rf "$DOTFILES_DIR"
	fi

	echo "[DONE] Uninstallation complete."
	exit 0
fi


echo "--> Install dependencies..."
sudo apt update
sudo apt install -y git mc vim


if [ -d "$DOTFILES_DIR" ]; then
	echo "--> Updating bare-repository..."
	git pull
else
	echo "--> Clonning bare-repository..."
	git clone --bare "$REPO_URL" "$DOTFILES_DIR"

	git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" config core.sparseCheckout true
	SPARSE_FILE="$DOTFILES_DIR/info/sparse-checkout"
	mkdir -p "$(dirname "$SPARSE_FILE")"
	cat <<-EOF | sed 's/^[[:space:]]\{1,\}//' > "$SPARSE_FILE"
		*
		!install.sh
		!README.md
	EOF

	echo "--> Hiding untracked files..."
	git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" config --local status.showUntrackedFiles no

	echo "--> Checking out dotfiles into \$HOME..."
	git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" checkout
fi


if ! grep -Fxq "$BASHRC_SOURCE_LINE" "$BASHRC"; then
    echo "--> Adding custom config source to .bashrc..."
    echo "$BASHRC_SOURCE_LINE" >> "$BASHRC"
fi

echo "[Done] Installation complete."
