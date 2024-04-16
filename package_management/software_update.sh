#!/bin/bash

#Update package lists
echo "Updating package lists..."
apt update

#Upgrade installed packages
echo "Upgrading installed packages..."
apt upgrade

#Clean up unused packages and cache
echo "Cleaning up unused packages and cache..."
apt autoremove
apt clean

read -p "Update completed. Press Enter to continue..."
