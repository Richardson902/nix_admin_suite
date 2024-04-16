#!/bin/bash

#Function to add package_update.sh to crontab
add_to_crontab() {
    local schedule="$1"
    local command="$2"
    # Add the scheduling line to the crontab
    sh -c "echo '$schedule $command' >> /etc/crontab"
    echo "Package update scheduled successfully."
    read -p "Press Enter to continue..."
}

#Define schedule and command for package update
schedule="0 2 * * 1" # Run at 2am weekly
command="/bin/bash ./package_management/software_update.sh"

#Add package update to crontab
add_to_crontab "$schedule" "$command"

