#!/bin/bash

tput civis  #Hide cursor
clear
echo "Press Enter to return to monitoring menu..."
echo ""

while true; do
    printf "Memory Usage: "
    tput sc  #Save cursor position
    free -m | awk '/Mem/{print $3}' | tr -d '\n'  #Print used memory without newline
    echo -n " MB"
    tput rc  #Restore cursor position
    read -s -t 2 -n 1
    if [ $? -eq 0 ]; then
        break
    fi
    echo -ne "\r\033[K"  #Clear the line
done

tput cnorm  #Restore cursor

