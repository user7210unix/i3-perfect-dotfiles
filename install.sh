#!/bin/bash

# Display Custom ASCII Art
echo "   ___    ____    ______  ____  ____  __     ____  ____ "
echo "  / _ \  / __ \  /_  __/ / __/ /  _/ / /    / __/ / __/ "
echo " / //_ <  / // / /_/ /   / /   / _/  _/ /__  / _/  _\ \  "
echo "/____/  \____/   /_/   /_/   /___/ /____/ /___/ /___/  "
echo "                                                        "
echo ""

# Function to show a progress bar
progress_bar() {
    local duration=$1
    local interval=5
    local count=$((duration / interval))
    
    echo -n "["
    for ((i = 0; i < count; i++)); do
        echo -n "#"
        sleep $interval
    done
    echo "] Done"
}

# Determine the distro
DISTRO=$(awk -F= '/^ID=/{print $2}' /etc/os-release)

# Function to install dependencies based on distro
install_dependencies() {
  case $1 in
    arch)
      echo "Installing dependencies for Arch-based systems..."
      sudo pacman -S --noconfirm rxvt-unicode polybar fish i3 unzip
      ;;
    Debian | Ubuntu | LinuxMint)
      echo "Installing dependencies for Debian/Ubuntu/Mint..."
      sudo apt update && sudo apt install -y rxvt-unicode polybar fish i3 unzip
      ;;
    Gentoo)
      echo "Installing dependencies for Gentoo..."
      sudo emerge --noreplace x11-terms/rxvt-unicode polybar x11-wm/i3 unzip
      ;;
    Fedora)
      echo "Installing dependencies for Fedora..."
      sudo dnf install -y rxvt-unicode polybar fish i3 unzip
      ;;
    Opensuse)
      echo "Installing dependencies for openSUSE..."
      sudo zypper install -y rxvt-unicode polybar fish i3 unzip
      ;;
    *)
      echo "Unsupported distribution: $1"
      exit 1
      ;;
  esac
}

# Install dependencies based on the distro
install_dependencies $DISTRO
progress_bar 10  # Simulate the time for installation

# Install custom Picom fork
echo "Installing custom Picom fork..."
git clone https://github.com/pijulius/picom.git && cd picom
progress_bar 15  # Simulate install time
meson --buildtype=release . build && ninja -C build && sudo ninja -C build install
cd ..

# Install Nerd Fonts (JetBrainsMono and Hack)
echo "Installing Nerd Fonts..."
mkdir -p $HOME/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip -O $HOME/.fonts/JetBrainsMono.zip
unzip $HOME/.fonts/JetBrainsMono.zip -d $HOME/.fonts/
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip -O $HOME/.fonts/Hack.zip
unzip $HOME/.fonts/Hack.zip -d $HOME/.fonts/
fc-cache -vf
progress_bar 10  # Simulate install time

# Clone the dotfiles repository
echo "Cloning dotfiles repository..."
git clone https://github.com/user7210unix/i3-perfect-dotfiles.git $HOME/i3-perfect-dotfiles
progress_bar 10  # Simulate clone time

# Symlink dotfiles
echo "Symlinking dotfiles..."
ln -sf $HOME/i3-perfect-dotfiles/.Xresources $HOME/.Xresources
ln -sf $HOME/i3-perfect-dotfiles/.xinitrc $HOME/.xinitrc
ln -sf $HOME/i3-perfect-dotfiles/.config/i3 $HOME/.config/i3
ln -sf $HOME/i3-perfect-dotfiles/.config/fish $HOME/.config/fish
ln -sf $HOME/i3-perfect-dotfiles/.config/picom $HOME/.config/picom
ln -sf $HOME/i3-perfect-dotfiles/.config/polybar $HOME/.config/polybar
ln -sf $HOME/i3-perfect-dotfiles/.config/rofi $HOME/.config/rofi
ln -sf $HOME/i3-perfect-dotfiles/wallpapers $HOME/
progress_bar 5  # Simulate symlink time

# Finish
echo "Installation complete!"
echo ""
echo "Start the Setup with the Command -> startx"

