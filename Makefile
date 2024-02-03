.PHONY: info all git vim shell tmux mac brew karabiner other

info:
	@echo "all: universal configs - git, shell, tmux, vim" 
	@echo "mac: macos-specific configs - homebrew, karabiner. NOTE: need to install xcode tools first"

all: git shell tmux vim other

# Symlink gitconfig
# Create+symlink gitconfig.local.git
git:
	@ln -s ${HOME}/dotfiles/git/gitconfig.git ${HOME}/.gitconfig
	@echo "# vim: set ft=gitconfig:" > ${HOME}/dotfiles/git/gitconfig.local.git
	@ln -s ${HOME}/dotfiles/git/gitconfig.local.git ${HOME}/.gitconfig.local
	@echo "symlinked git stuff"

# Change shell to zsh
# Symlink .profile and .zshrc
# Create private.zsh
shell:
	@chsh -s $$(which zsh)
	@ln -s ${HOME}/dotfiles/shell/profile.zsh ${HOME}/.profile
	@ln -s ${HOME}/dotfiles/shell/zshrc.zsh ${HOME}/.zshrc
	@echo "# vim: set ft=zsh:" > ${HOME}/dotfiles/shell/private.zsh
	@echo "symlinked shell stuff"

# Clone tmux plugin manager
# Symlink .tmux.conf
tmux:
	@git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	@ln -s ${HOME}/dotfiles/tmux/tmux.conf ${HOME}/.tmux.conf
	@echo "symlinked tmux stuff"

# Install vundle
# Symlink .vimrc and .gvimrc
vim:
	@git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	@ln -s ${HOME}/dotfiles/vim/vimrc.vim ${HOME}/.vimrc
	@ln -s ${HOME}/dotfiles/vim/gvimrc.vim ${HOME}/.gvimrc
	@vim +PluginInstall +qall
	@mkdir -p ${HOME}/.config/nvim
	@ln -s ${HOME}/dotfiles/vim/nvim.vim ${HOME}/.config/nvim/init.vim
	@echo "symlinked vim stuff"

other:
	@echo "TODO: [ ] Set terminal colors"
	@echo "TODO: [ ] source .zshrc"
	@echo "TODO: [ ] populate ./git/gitconfig.local.git"
	@echo "TODO: [ ] Install gvim/macvim"
	@echo "TODO: [ ] Run tmux, install plugins with <leader>-I"


mac: brew karabiner

# Install brew
brew:
	@/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Configures karabiner to turn fn+hjkl into arrow keys
karabiner:
	@cp ${HOME}/dotfiles/karabiner/fn-hjkl.json ${HOME}/.config/karabiner/assets/complex_modifications/fn-hjkl.json
	@echo "TODO: [ ] Navigate to karabiner://karabiner/assets/complex_modifications/import?url=file%3A%2F%2F%2F%2FUsers%2Fvignesh%2F.config%2Fkarabiner%2Fassets%2Fcomplex_modifications%2Ffn-hjkl.json"

