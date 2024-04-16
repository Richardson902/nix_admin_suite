#!/bin/bash

#Prompt for username
read -p "Enter username to remove: " username

#Check if user exists
if ! id "$username" &>/dev/null; then
	echo "User $username does not exist."
	read -p "Press Enter to continue..."
	exit 1
fi

#Remove the user
userdel -r $username

#Check if the user was removed sucessfully
if [ $? -eq 0 ]; then
	read -p "User $username removed sucessfully. Press Enter to continue..."
else
	echo "Failed to remove user $username. Please check error messages above."
	read -p "Press Enter to continue..."
fi

clear
