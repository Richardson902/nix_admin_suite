#!/bin/bash

#Prompt for username
read -p "Enter username: " username

#Check if user already exists
if id "$username" &>/dev/null; then
	echo "User $username already exists."
	read -p "Press Enter to continue..."
	exit 1
fi

#Prompt for additional user details
read -p "Enter full name: " full_name
read -p "Enter initial group (default: users): " initial_group

#Sed default group if not provided
initial_group=${initial_group:-users} #You can change this if you want the default to be different

#Create the user
useradd -m -g "$initial_group" -c "$full_name" $username

#Check if user was created sucessfully
if [ $? -eq 0 ]; then
	read -p "User $username created sucessfully. Press Enter to continue..."
else
	echo "Failed to create user $username. Please check error messages above."
	read -p "Press Enter to continue..."
fi

clear
