.PHONY: info all git vim shell tmux mac brew karabiner other

info:
	@echo "all: universal configs - git, shell, tmux, vim" 
	@echo "mac: macos-specific configs - homebrew, karabiner. NOTE: need to install xcode tools first"

all: git shell tmux vim other

# Symlink gitconfig
# Create+symlink gitconfig.local.git
git:
	@ln -s ${HOME}/dotfiles/git/gitconfig.git ${HOME}/.gitconfig
	@touch ${HOME}/dotfiles/git/gitconfig.local.git
	@ln -s ${HOME}/dotfiles/git/gitconfig.local.git ${HOME}/.gitconfig.local
	@echo "symlinked git stuff"

# Change shell to zsh
# Symlink .profile and .zshrc
# Create private.zsh
shell:
	@chsh -s $$(which zsh)
	@ln -s ${HOME}/dotfiles/shell/profile.zsh ${HOME}/.profile
	@ln -s ${HOME}/dotfiles/shell/zshrc.zsh ${HOME}/.zshrc
	@touch ${HOME}/dotfiles/shell/private.zsh
	@echo "symlinked shell stuff"

# Symlink .tmux.conf
tmux:
	@ln -s ${HOME}/dotfiles/tmux/tmux.conf ${HOME}/.tmux.conf
	@echo "symlinked tmux stuff"

# Symlink .vimrc and .gvimrc
vim:
	@ln -s ${HOME}/dotfiles/vim/vimrc.vim ${HOME}/.vimrc
	@ln -s ${HOME}/dotfiles/vim/gvimrc.vim ${HOME}/.gvimrc
	@echo "symlinked vim stuff"

other:
	@echo "TODO: [ ] populate ./git/gitconfig.local.git"
	@echo "TODO: [ ] Set terminal colors"
	@echo "TODO: [ ] Install gvim/macvim"


mac: brew karabiner

# Install brew
brew:
	@/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Configures karabiner to turn fn+hjkl into arrow keys
karabiner:
	@cp ${HOME}/dotfiles/karabiner/fn-hjkl.json ${HOME}/.config/karabiner/assets/complex_modifications/fn-hjkl.json
	@echo "TODO: [ ] Navigate to karabiner://karabiner/assets/complex_modifications/import?url=file%3A%2F%2F%2F%2FUsers%2Fvignesh%2F.config%2Fkarabiner%2Fassets%2Fcomplex_modifications%2Ffn-hjkl.json"
	# TODO: resolve url above, write a shell script to find $HOME then replace / with %2F

