.PHONY: all apt nix font clean-stow stow shell

all: apt nix font stow shell

apt:
	@echo "==> Instalando bases do sistema..."
	sudo apt update
	sudo apt install -y i3 fish stow xclip curl git polybar rofi feh picom flameshot
	@echo "==> Instalando kitty (versão binária isolada)..."
	curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
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
	nixpkgs#neovim \
	--extra-experimental-features "nix-command flakes"

font:
	@echo "==> Instalando fontes via Nix e configurando links..."
	. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh && \
	nix profile add nixpkgs#nerd-fonts.jetbrains-mono --extra-experimental-features "nix-command flakes"
	mkdir -p ~/.local/share/fonts
	ln -sf ~/.nix-profile/share/fonts ~/.local/share/fonts/nix
	@echo "==> Atualizando cache de fontes do sistema..."
	fc-cache -fv

clean-stow:
	@echo "==> Removendo configurações antigas..."
	rm -rf ~/.config/kitty ~/.config/fish ~/.config/i3 ~/.config/starship.toml ~/.config/nvim ~/.config/polybar ~/.config/rofi ~/.config/picom ~/.config/dunst

stow: clean-stow
	@echo "==> Aplicando dotfiles com Stow..."
	stow kitty fish i3 starship nvim polybar rofi picom dunst

shell:
	@echo "==> Mudando shell para o Fish..."
	chsh -s $$(which fish)
