.PHONY: all apt nix clean-stow stow shell

all: apt nix stow shell

apt:
	@echo "==> Instalando bases do sistema..."
	sudo apt update
	sudo apt install -y i3 kitty fish stow xclip curl git polybar rofi feh picom flameshot
	@echo "==> Instalando nix"
	curl -L https://nixos.org/nix/install | sh -s -- --daemon

nix:
	@echo "==> Instalando ferramentas via Nix..."
	. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh && \
	nix profile add \
	nixpkgs#starship \
	nixpkgs#direnv \
	nixpkgs#zoxide \
	nixpkgs#fzf \
	nixpkgs#ripgrep \
	nixpkgs#btop \
	nixpkgs#lazydocker \
	nixpkgs#lazygit \
	nixpkgs#bat \
	nixpkgs#yazi \
	nixpkgs#eza \
	nixpkgs#gh \
	nixpkgs#delta \
	nixpkgs#neovim
	
clean-stow:
	@echo "==> Removendo configurações antigas..."
	rm -rf ~/.config/kitty ~/.config/fish ~/.config/i3 ~/.config/starship.toml ~/.config/nvim ~/.config/polybar ~/.config/rofi ~/.config/picom

stow: clean-stow
	@echo "==> Aplicando dotfiles com Stow..."
	stow kitty fish i3 starship nvim polybar rofi picom

shell:
	@echo "==> Mudando shell para o Fish..."
	chsh -s $$(which fish)
