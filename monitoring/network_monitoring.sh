#!/bin/bash

while true; do
    clear
    echo "Press Enter to return to monitoring menu..."
    echo ""
    echo "Network Usage:"
    netstat -i #Make sure you have run "Install Required Packages" In the package manager as this uses net-tools
    read -s -t 2 -n 1
    if [ $? -eq 0 ]; then
        break
    fi
done

