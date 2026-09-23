#!/bin/bash
echo "Iniciando a instalação do ambiente..."


echo "Instalando base do sistema (nix, i3, kitty, fish, stow, xclip)..."
sudo apt update
curl -L https://nixos.org/nix/install | sh -s -- --daemon
sudo apt install -y i3 kitty fish stow xclip curl git polybar rofi feh picom flameshot


. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
echo "Instalando ferramentas de terminal via Nix..."
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

echo "Aplicando configurações (Dotfiles)..."

rm -rf ~/.config/kitty ~/.config/fish ~/.config/i3 ~/.config/starship.toml

stow kitty fish i3 starship

echo "Mudando shell padrão para o Fish..."
chsh -s $(which fish)

echo "Instalação concluída! Reinicie o computador ou faça logout para entrar no i3wm."
