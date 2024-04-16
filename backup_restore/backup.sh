#!/bin/bash

#THIS IS JUST A DEMO OF FUNCTIONALITY UNLESS YOU HAVE A USE FOR BACKKING UP THE /TMP FOLDER

#Define variables
BACKUP_SRC="/tmp" #FEEL FREE TO CHANGE TO MAKE IT USEFUL
BACKUP_DST="/backups"
BACKUP_DATE=$(date +%Y%m%d%H%M%S)
BACKUP_FILENAME="backup_$BACKUP_DATE.tar.gz"

#If folder doesn't exist, create it
mkdir -p "$BACKUP_DST"

#Archive the source directory
tar -czf "$BACKUP_DST/$BACKUP_FILENAME" "$BACKUP_SRC"

#Verify success
if [ $? -eq 0 ]; then
	echo "Backup was sucessful: $BACKUP_FILENAME"
else
	echo "Backup failed"
fi

read -p "Press Enter to continue..."
