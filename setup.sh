#!/bin/bash

sudo dnf update

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
  gnome-tweaks
  vlc
  gimp
  ghostty
)

echo "Adding Docker repository..."
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

echo "Adding ghostty repository"
sudo dnf copr enable pgdev/ghostty

echo "Installing packages..."
sudo dnf install -y ${packages[@]}

echo "Adding Flathub repository..."
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpaks=(
  com.mattjakeman.ExtensionManager  
  com.obsproject.Studio
  com.discordapp.Discord
  app.zen_browser.zen
)

echo "Installing Flatpaks..."
sudo flatpak install flathub -y ${flatpaks[@]}


echo "Copying configuration files..."
# Ensure the target directories exist
mkdir -p /home/$USER/.config
mkdir -p /home/$USER/.config/ghostty
cp ./ghostty-config /home/$USER/.config/ghostty/config
cp -r ./nvim /home/$USER/.config

echo "Configuring .bashrc file ..."
BASHRC_FILE="/home/$USER/.bashrc"

FNM_MARKER="# fnm"

# if no marker, write the script
if ! grep -qF "$FNM_MARKER" "$BASHRC_FILE"; then

  echo "Installing fnm (Node Version Manager)..."
  curl -fsSL https://fnm.vercel.app/install | bash

  echo "Installing pnpm..."
  curl -fsSL https://get.pnpm.io/install.sh | sh -

else
  echo "FNM & PNPM already installed"
fi

