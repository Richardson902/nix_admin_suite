#!/bin/bash

#THIS IS JUST A DEMO OF FUNCTIONALITY UNLESS YOU HAVE A USE TO RESTORE THE /TMP FOLDER

# Define backups directory
BACKUPS_DIR="/backups"

#List available backups
echo "Available backups:"
ls "$BACKUPS_DIR"

#Prompt user to choose a backup
read -p "Enter the name of the backup to restore: " backup_name

#Check if the selected backup exists
backup_file="$BACKUPS_DIR/$backup_name"
if [ ! -f "$backup_file" ]; then
    echo "Error: Backup '$backup_name' not found."
    read -p "Press Enter to continue..."
    exit 1
fi

#Extract the backup to directory // FEEL FREE TO CHANGE TO MAKE IT ACTUALLY USEFUL
echo "Restoring backup '$backup_name' to /tmp directory..."
tar -xzf "$backup_file" -C /tmp

#Verify success
if [ $? -eq 0 ]; then
    echo "Restore completed successfully."
else
    echo "Error: Restore failed."
fi

read -p "Press Enter to continue..."
