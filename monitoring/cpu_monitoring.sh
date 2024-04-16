#!/bin/bash

tput civis #Hide cursor
clear
echo "Press Enter to return to monitoring menu..."
echo ""

while true; do
    printf "CPU: "
    tput sc  #Save cursor position
    top -bn1 | grep '%Cpu' | sed 's/^.*: *//' | cut -d " " -f 1 | tr -d '\n'  #Print CPU usage without newline
    tput rc  #Restore cursor position
    read -s -t 2 -n 1
    if [ $? -eq 0 ]; then
        break
    fi
    echo -ne "\r\033[K"  #Clear the line
done

tput cnorm #Restore cursor

