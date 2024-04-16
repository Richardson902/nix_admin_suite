#!/bin/bash

#Function to validate permissions input
validate_permissions() {
	if [[ "$1" =~ ^[r-][w-][x-]$ ]]; then
		return 0;
	else
		return 1
	fi
}

#Function to validate group input
validate_group() {
	if grep -q "^$1:" /etc/group; then
		return 0
	else
		return 1
	fi
}

#Function to list groups
list_groups() {
	echo "Existing groups:"
	cut -d: -f1 /etc/group
}

#Function to list users
list_users() {
	echo "Existing users:"
	while IFS=: read -r username _ _ groups; do
		echo "User: $username | Groups: $(groups $username)"
	done </etc/passwd
}

#Prompt for input
while true; do
	clear
	echo "Group Manager"
	echo "-------------"
	echo "[1] Add user to group"
	echo "[2] Remove user from group"
	echo "[3] Modify group permissions"
	echo "[4] List existing groups"
	echo "[5] List existing users"
	echo "[6] Delete group"
	echo "[0] Back to User Management"
	read -p "Enter your choice: " choice

	case $choice in
		1)
			#Prompt for group name to add user to
			read -p "Enter group name to add user to: " group_name_add
			#Check if group exists
			if ! validate_group "$group_name_add"; then
				echo "Group $group_name_add does not exist. Do you want to create it? [y/n]"
				read create_group_response
				if [[ "$create_group_response" =~ ^[Yy]$ ]]; then
					groupadd "$group_name_add"
					if [ $? -ne 0 ]; then
						echo "Failed to create group $group_name_add. Exiting."
						read -p "Press Enter to continue..."
						exit 1
					fi
				else
					echo "Exiting."
					sleep 1
					continue
				fi
			fi
			
			#Prompt for username
			read -p "Enter username to add: " username
			#Check if user exists
			if ! id "$username" &>/dev/null; then
				read -p "User $username does not exist."
				continue
			fi
			#Add user to group
			usermod -aG $group_name_add $username
			echo "User $username added to group $group_name_add sucessfully."
			read -p "Press Enter to continue..."
			;;
		2)
			#Prompt for group name to remove user from
			read -p "Enter group name to remove user from: " group_name_remove
			#Check if group exists
			if ! validate_group "$group_name_remove"; then
				read -p "Group $group_name_remove does not exist."
				continue
			fi
			#Prompt for username
			read -p "Enter username to remove: " username
			#Check if user is a member of the group
			if ! groups $username | grep -q "\<group_name_remove\>"; then
				echo "User $username is not a member of group $group_name_remove."
				read -p "Press Enter to continue..."
				continue
			fi
			#Remove user from group
			deluser $username $group_name_remove
			read -p "User $username removed from group $group_name_remove sucessfully."
			;;
		3)
			#Prompt for group name to edit permisisons for
			read -p "Enter group name to edit permisisons for: " group_name_edit
			#Check if group exists
			if ! validate_group "$group_name_edit"; then
				echo "Group $group_name_edit does not exist."
				read -p "Press Enter to continue..."
				continue
			fi
			
			#Prompt for directory
			read -p "Enter directory to set permissions for: " directory
			
			#Check if directory exists
			if [ ! -d "$directory" ]; then
				echo "Directory '$directory' does not exist."
				read -p "Press Enter to continue..."
				continue
			fi
			
			#Prompt for permissions
			read -p "Enter permissions for the group (e.g., rw-, default: r--): " permissions
			#Set default permissions if not provided
			permissions=${permissions:-r--}
			#Validate permissions input
			if ! validate_permissions "$permissions"; then
				echo "Invalid permissions input. Permissions must be in the format 'rwx'."
				read -p "Press Enter to continue..."
				continue
			fi
			#Set permissions for the group
			chmod g=$permissions "$directory"
			echo "Group $group_name_edit permissions updated to $permissions for directory $directory successfully."
			read -p "Press Enter to continue..."
			;;
		4)
			list_groups
			read -p "Press enter to continue..."
			;;
		5)
			list_users
			read -p "Press enter to continue..."
			;;
		6)
			#Prompt for group name to delete
			read -p "Enter the name of the group you want to delete: " group_name
			
			#Check if the group exists
			if validate_group "$group_name"; then
				#Group exists, proceed with deletion
				groupdel "$group_name"
				if [ $? -eq 0 ]; then
					echo "Group $group_name deleted sucessfully."
					read -p "Press Enter to continue..."
				else
					echo "Failed to delete group $group_name."
					read -p "Press Enter to continue..."
					continue
				fi
			else
				#Group does not exist
				echo "Group $group_name does not exist."
				read -p "Press Enter to continue..."
				continue
			fi
			;;
		0)
			clear
			exit 1
			;;
		*)
			read -p "Invalid option. Please try again."
			;;
	esac
done	
