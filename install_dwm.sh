#!/bin/bash

# Step 1: Create the directory .local/src
echo "Creating .local/src directory..."
mkdir -p $HOME/.local/src

# Step 2: Install dependencies using pacman
echo "Installing required dependencies..."
sudo pacman -S --noconfirm git libxft libxinerama xterm

# Step 3: Clone the necessary repositories
echo "Cloning dwm, st, and dmenu repositories..."
cd $HOME/.local/src
git clone https://github.com/bugswriter/dwm.git
git clone https://github.com/bugswriter/st.git
git clone https://github.com/bugswriter/dmenu.git

# Step 4: Build and install each project
echo "Building and installing dwm..."
cd dwm
sudo make clean install

echo "Building and installing st..."
cd $HOME/.local/src/st
sudo make clean install

echo "Building and installing dmenu..."
cd $HOME/.local/src/dmenu
sudo make clean install

# Step 5: Return to the main directory
cd $HOME

# Step 6: Check if /etc/X11/xinit/xinitrc exists and copy it to ~/.xinitrc
echo "Checking if /etc/X11/xinit/xinitrc exists..."
if [ -f /etc/X11/xinit/xinitrc ]; then
    echo "Copying /etc/X11/xinit/xinitrc to ~/.xinitrc..."
    cp /etc/X11/xinit/xinitrc ~/.xinitrc
else
    echo "Error: /etc/X11/xinit/xinitrc not found. Please install xorg-xinit."
    exit 1
fi

# Step 7: Remove the last 5 lines of ~/.xinitrc
echo "Removing the last 5 lines of ~/.xinitrc..."
head -n -5 ~/.xinitrc > ~/.xinitrc.tmp && mv ~/.xinitrc.tmp ~/.xinitrc

# Step 8: Add exec dwm to the bottom of ~/.xinitrc
echo "Adding exec dwm to the bottom of ~/.xinitrc..."
echo "exec dwm" >> ~/.xinitrc

# Ensure .xinitrc is correctly set up after reboot
if ! grep -q "exec dwm" ~/.xinitrc; then
    echo "exec dwm not found in ~/.xinitrc, adding it now."
    echo "exec dwm" >> ~/.xinitrc
else
    echo "exec dwm already exists in ~/.xinitrc."
fi

# Step 9: Ensure .xinitrc is correctly populated
if [ ! -s ~/.xinitrc ]; then
    echo "Error: ~/.xinitrc is empty after script ran. Something went wrong!"
    exit 1
else
    echo "~/.xinitrc successfully set up."
fi

# Step 10: Install fonts
echo "Installing fonts ttf-jetbrains-mono and ttf-font-awesome..."
sudo pacman -S --noconfirm ttf-jetbrains-mono ttf-font-awesome

# Step 11: Run startx to start X
echo "Running startx..."
startx

