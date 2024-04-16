#!/bin/bash

#Function to remove tasks from crontab
remove_from_crontab() {
    local command1="$1"
    local command2="$2"
    # Remove the scheduling lines from the crontab
    sed -i "\|$command1|d" /etc/crontab
    sed -i "\|$command2|d" /etc/crontab
    echo "Tasks removed from crontab schedule."
    read -p "Press Enter to continue..."
}

#Define commands to remove
command1="/bin/bash ./backup_restore/backup.sh"
command2="/bin/bash ./package_management/software_update.sh"

#Remove tasks from crontab
remove_from_crontab "$command1" "$command2"

