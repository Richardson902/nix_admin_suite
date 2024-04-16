#!/bin/bash

#Update package lists
echo "Updating package lists..."
apt update

#Install desired packages
echo "Installing requires packages for admin suite..."
apt install net-tools lynis #Add more packages here that you wish to be added in addition

#Remove unwanted packages
echo "Removing unwanted packages..."
apt remove #Add Packages here that you want to remove

#Upgrade installed packages
echo "Upgrading installed packages..."
apt upgrade

#Clean up unused packages and cache
echo "Cleaning up unused packages and cache..."
apt autoremove
apt clean

read -p "Installing required packages completed. Press Enter to continue..."

