#!/bin/bash

packages=(
  neovim
  tmux
  fastfetch
  zip
  unzip
  wget
  curl
  flatpak
  gh
  git
  fnm
  gnome
  gnome-tweaks
  gnome-disk-utility
  vlc
  gimp
)

dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

dnf install -y ${packages[@]}

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpaks=(
  com.mattjakeman.ExtensionManager  
  com.brave.Browser
  com.obsproject.Studio
  com.obsproject.Studio
  com.obsproject.Studio.Plugin.DroidCam
)

flatpak install flathub -y ${flatpaks[@]}

flatpak override --user --device=all com.obsproject.Studio

cp ./.tmux.conf /home/$USER/.tmux.conf
cp -r ./nvim /home/$USER/.config/nvim
