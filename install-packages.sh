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
  gnome-tweaks
  vlc
  gimp
)

echo "Adding Docker repository..."
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

echo "Installing packages..."
sudo dnf install -y ${packages[@]}

echo "Installing fnm (Node Version Manager)..."
curl -fsSL https://fnm.vercel.app/install | bash

echo "Installing pnpm..."
curl -fsSL https://get.pnpm.io/install.sh | sh -

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
cp ./.tmux.conf /home/$USER/.tmux.conf
cp -r ./nvim /home/$USER/.config/nvim

echo "Configuring tmux auto-start in .bashrc..."
BASHRC_FILE="/home/$USER/.bashrc"
TMUX_CONFIG_MARKER="# Automatically start tmux"

# if no marker, write the script
if ! grep -qF "$TMUX_CONFIG_MARKER" "$BASHRC_FILE"; then
  cat << 'EOF' >> "$BASHRC_FILE"

# Automatically start tmux
if [[ $- == *i* ]] && [ -z "$TMUX" ] && command -v tmux >/dev/null 2>&1; then
  # Attach to the last session or create a new one if none exist
  tmux attach-session || tmux new-session
fi
EOF
  echo "Added tmux auto-start configuration to $BASHRC_FILE."
else
  # If marker was found, do nothing
  echo "tmux auto-start configuration marker already found in $BASHRC_FILE. Skipping."
fi

