#!/bin/bash

#Function to add backup.sh to crontab
add_to_crontab() {
    local schedule="$1"
    local command="$2"
    #Add the scheduling line to the crontab
    sh -c "echo '$schedule $command' >> /etc/crontab"
    echo "Backup scheduled successfully."
    read -p "Press Enter to continue..."
}

# Define schedule and command for backup
schedule="0 4 * * 1" # Run at 4am weekly
command="/bin/bash ./backup_restore/backup.sh"

#Add backup to crontab
add_to_crontab "$schedule" "$command"

