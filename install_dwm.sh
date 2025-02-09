#!/bin/bash

# Step 1: Create the directory .local/src
echo "Creating .local/src directory..."
mkdir -p $HOME/.local/src

# Step 2: Install dependencies using pacman
echo "Installing required dependencies..."
sudo pacman -S --noconfirm git libxft libxinerama

# Step 3: Clone the necessary repositories
echo "Cloning dwm, st, and dmenu repositories..."
cd $HOME/.local/src
git clone https://github.com/Nerdrantz/dwm.git
git clone https://github.com/Nerdrantz/st.git
git clone https://github.com/Nerdrantz/dmenu.git

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

# Step 6: Copy /etc/X11/xinit/xinitrc to ~/.xinitrc
echo "Copying /etc/X11/xinit/xinitrc to ~/.xinitrc..."
cp /etc/X11/xinit/xinitrc ~/.xinitrc

# Step 7: Add exec dwm to the bottom of ~/.xinitrc
echo "Adding exec dwm to the bottom of ~/.xinitrc..."
echo "exec dwm" >> ~/.xinitrc

# Step 8: Run startx to start X
echo "Running startx..."
startx

