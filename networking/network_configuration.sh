#!/bin/bash

#Network Configuration Script

#Function to automatically detect the network interface // You can remove this if you want a specific network interface
detect_network_interface() {
    #Fetching the default gateway IP address
    gateway=$(ip route show | grep default | awk '{print $3}')
    #Using the gateway to find the associated network interface
    interface=$(ip route get $gateway | grep dev | awk '{print $5}')
    echo "$interface"
}

#Automatically detect the network interface
network_interface=$(detect_network_interface) #You can change this if you want a specific network interface

clear
echo "Network Configuration Menu"
echo "--------------------------"
echo "[1] Set IP Address"
echo "[2] Set Subnet Mask"
echo "[3] Set Gateway"
echo "[4] Set DNS Server"
echo "[0] Back to Networking Menu"

read -p "Enter your choice: " choice

case $choice in
    1)
        read -p "Enter IP Address: " ip_address
        ip addr add $ip_address dev $network_interface
        ;;
    2)
        read -p "Enter Subnet Mask: " subnet_mask
        ifconfig $network_interface netmask $subnet_mask
        ;;
    3)
        read -p "Enter Gateway: " gateway
        route add default gw $gateway $network_interface
        ;;
    4)
        read -p "Enter DNS Server: " dns_server
        echo "nameserver $dns_server" > /etc/resolv.conf
        ;;
    0)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid option. Please try again."
        ;;
esac

